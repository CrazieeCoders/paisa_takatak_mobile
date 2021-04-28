import 'package:http/http.dart' as http;
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/model/household_model.dart';
import 'package:paisa_takatak_mobile/model/otp_model.dart';
import 'package:paisa_takatak_mobile/model/registeration_model.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:paisa_takatak_mobile/model/upload_files_model.dart';
import 'package:paisa_takatak_mobile/model/upload_files_error_model.dart';
import 'dart:developer';


class APIService{

 // static String baseUrl = 'http://13.232.165.118:8085';
  //test url
  static String baseUrl = 'http://65.2.71.71:8085';
  static String baseUrl1 = 'http://13.232.165.118:8085/swagger-ui.html#/';
  static String authorizationToken ='';
  SharedPrefs _sharedPrefs = SharedPrefs();


   Future<String> generateOtp(String ph) async{

    var res = await  http.post(baseUrl+'/otp/generate?number=$ph');

    print('${res.body}');

    final  otpModel = otpModelFromJson(res.body);
    authorizationToken = otpModel.responseObject.token;
    _sharedPrefs.setAuthorizationToken(authorizationToken);
    _sharedPrefs.setSelfieStatus(otpModel.responseObject.documentStatus.selfiePhoto);
    _sharedPrefs.setPanStatus(otpModel.responseObject.documentStatus.panCard);
    _sharedPrefs.setAadharFrontStatus(otpModel.responseObject.documentStatus.aadharCard);
    _sharedPrefs.setAadharBackStatus(otpModel.responseObject.documentStatus.aadharCard);
    _sharedPrefs.setChequeStatus(otpModel.responseObject.documentStatus.cancelledCheque);
    _sharedPrefs.setBankStatementStatus(otpModel.responseObject.documentStatus.bankStatement);
    
    _sharedPrefs.setLoanApplicationForm(otpModel.responseObject.documentStatus.loanApplicationForm);
    _sharedPrefs.setLoanAgreementSigned(otpModel.responseObject.documentStatus.loanAgreementSigned);
    _sharedPrefs.setHouseholdStatus(otpModel.responseObject.documentStatus.houseHoldStatus);
    _sharedPrefs.setHouseholdFlag(otpModel.responseObject.documentStatus.houseHoldFlag);
    _sharedPrefs.setLoanApplicationUnderProcess(otpModel.responseObject.documentStatus.loanApplicationUnderProcess);


    String otp = _returnResponse(otpModel);

    otp = utf8.decode(base64.decode(otpModel.responseObject.encyPass));

     return otp;
  }


   uploadFilesAndImages({String ph,File file,String fileName}) async{

     authorizationToken = _sharedPrefs.getAuthorizationToken;

     if(fileName == 'pan_card'|| fileName == 'aadhar_card_front'|| fileName == 'aadhar_card_back'){
       var request = http.MultipartRequest('POST',Uri.parse(baseUrl+'/uploadDocs/uploadCustomerFile/'));

       request.headers['Authorization'] =authorizationToken;
       request.fields['fileName'] = fileName;
       request.fields['number'] =ph;

       request.files.add(
           http.MultipartFile(
               'files',
               File(file.path).readAsBytes().asStream(),
               File(file.path).lengthSync(),
               filename: file.path.split("/").last
           )
       );

       var response = await request.send();
       print(response.stream);
       print(response.statusCode);
       final res = await http.Response.fromStream(response);
       print('Came after Http post');

       debugPrint(res.body, wrapWidth: 4024);
       log(res.body);

       final uploadFileErrorModel = uploadFileErrorModelFromJson(res.body);

       if(!(uploadFileErrorModel.responseObject[0].ocrResponse.responseObject == null)){

         final uploadFileModel = uploadFileModelFromJson(res.body);
         print('${uploadFileModel.responseStatus}');
         _returnResponse1(uploadFileModel);

         List ocrList = uploadFileModel.responseObject;
         ResponseObjectElement responseObjectElement =  ocrList[0];



         switch(fileName){

           case 'pan_card':
             String panNumber = responseObjectElement.ocrResponse.responseObject.result.extractionOutput.idNumber ?? '';
             String userName = responseObjectElement.ocrResponse.responseObject.result.extractionOutput.nameOnCard ?? '';
             _sharedPrefs.setPanNumber(panNumber);
             _sharedPrefs.setUserName(userName);
             break;
           case 'aadhar_card_front':
            String uidNumber = responseObjectElement.ocrResponse.responseObject.result.extractionOutput.idNumber ?? '';
             _sharedPrefs.setUidNumber(uidNumber);

             break;
           case 'aadhar_card_back':
             String pinCode = responseObjectElement.ocrResponse.responseObject.result.extractionOutput.pincode ?? '';
             String permanentAddress =  responseObjectElement.ocrResponse.responseObject.result.extractionOutput.address ?? '';
             _sharedPrefs.setPermanentAddress(permanentAddress);
             _sharedPrefs.setPinCode(pinCode);
             break;

           default:
             break;
         }

       }else {
         throw InvalidFileException(msg:"Please upload the valid file");
       }



     }else {
       var request = http.MultipartRequest(
           'POST', Uri.parse(baseUrl + '/uploadDocs/uploadCustomerFile/'));

       request.headers['Authorization'] = authorizationToken;
       request.fields['fileName'] = fileName;
       request.fields['number'] = ph;

       request.files.add(
           http.MultipartFile(
               'files',
               File(file.path).readAsBytes().asStream(),
               File(file.path).lengthSync(),
               filename: file.path
                   .split("/")
                   .last
           )
       );

       var response = await request.send();
       print(response.stream);
       print(response.statusCode);
       final res = await http.Response.fromStream(response);
       print('Came after Http post');


       debugPrint(res.body, wrapWidth: 1024);
      // final uploadFileModel = uploadFileModelFromJson(res.body);
      // final uploadFileErrorModel = uploadFileErrorModelFromJson(res.body);
       //debugPrint('response body :${res.body}');
      // print('${uploadFileErrorModel.responseStatus}');


      // _returnResponse1(uploadFileErrorModel);
     }
  }


   registerLoanForm(RegisterationInfo registerationInfo)async{
     authorizationToken = _sharedPrefs.getAuthorizationToken;

     var res = await  http.post(Uri.encodeFull(baseUrl+'/registration/saveInfo/'),headers: {
       'Authorization':authorizationToken,
       "content-type": "application/json"
     },
       body:json.encode({
         "alternatePhoneNumber": registerationInfo.alternatePhNum,
         "loanAmount": registerationInfo.loanAmount,
         "loanTenure": registerationInfo.loanTenure,
         "localAddress": registerationInfo.localAddress,
         "panNumber": registerationInfo.panNumber,
         "permanentAddress":registerationInfo.permanentAddr,
         "phoneNumber": registerationInfo.phNum,
         "pinCode": registerationInfo.pinCode,
         "uidNumber": registerationInfo.uidNumber,
         "userName": registerationInfo.userName
       }),
     );

     print(' the response code is :${res.statusCode}');

   }


  Future<String> loanAgreementOtp(String ph) async{

    authorizationToken = _sharedPrefs.getAuthorizationToken;
    var res = await  http.post(Uri.encodeFull(baseUrl+'/otp/loanAgreementOTP?number=$ph'),
    headers:{
      'Authorization':authorizationToken,
      "content-type": "application/json"
    },
    );

    String  otp = utf8.decode(base64.decode(res.body));
    print('${otp}');
    print("the status code for LoanAgreemnt OTP is ${res.statusCode}");
    print("the the body for loan Agreemrent is  ${res.body}");
     return otp;
  }


  householdForm(HouseHold houseHold) async{

    authorizationToken = _sharedPrefs.getAuthorizationToken;
    String phNo = _sharedPrefs.getPhone;

    var res = await  http.post(Uri.encodeFull(baseUrl+'/household/saveInfo'),headers: {
      'Authorization':authorizationToken,
      "content-type": "application/json"
    },
      body:json.encode({
        "firstEmiAmount": houseHold.firstStEmi,
        "houseHoldExpenses": houseHold.householdExpense,
        "monthlyIncome": houseHold.monthlyIncome,
        "numOfDepend": houseHold.noOfDependents,
        "phoneNumber": phNo,
        "secondEmiAmount": houseHold.secondNdEmi,
        "thirdEmiAmount": houseHold.thirdRdEmi
      }),
    );

    print(' the response code is :${res.statusCode}');




  }



  static _returnResponse(OtpModel otpModel){


   switch(otpModel.responseStatusCode){
     case 200:
       return otpModel.responseObject.encyPass;
     break;
     case 201:
       throw ModelException(msg:"Not Valid Format");
     break;
     case 401:
       throw UnAuthorizedException(msg:"UnAuthorized !!");
       break;
     case 403:
       throw ForbiddenException(msg:"Forbidden Site");
       break;
     case 404:
       throw NotFoundException(msg:"Url not Found");
       break;

     default:
       throw FetchOtpException(msg: "Error occurred while communicating with server");
       break;
   }

  }



  static _returnResponse1(UploadFileModel validateModel){


    switch(validateModel.responseStatusCode){
      case 200:
        return validateModel.responseStatusCode;
        break;
      case 201:
        throw ModelException(msg:"Not Valid Format");
        break;
      case 401:
        throw UnAuthorizedException(msg:"UnAuthorized !!");
        break;
      case 403:
        throw ForbiddenException(msg:"Forbidden Site");
        break;
      case 404:
        throw NotFoundException(msg:"Url not Found");
        break;

      default:
        throw FetchOtpException(msg: "Error occurred while communicating with server");
        break;
    }

  }


}