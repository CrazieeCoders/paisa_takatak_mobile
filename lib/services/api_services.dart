import 'package:http/http.dart' as http;
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/model/otp_model.dart';
import 'package:paisa_takatak_mobile/model/registeration_model.dart';
import 'package:paisa_takatak_mobile/model/uploadFiles_model.dart';
import 'dart:convert';
import 'dart:io';

class APIService{

  static String baseUrl = 'http://13.232.165.118:8085';
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
    String otp = _returnResponse(otpModel);

    otp = utf8.decode(base64.decode(otpModel.responseObject.encyPass));

     return otp;
  }


   uploadFilesAndImages({String ph,File file,String fileName}) async{

     authorizationToken = _sharedPrefs.getAuthorizationToken;

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
    final validateModel = validateModelFromJson(res.body);

    print('${validateModel.responseStatus}');


   _returnResponse1(validateModel);
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



  static _returnResponse1(ValidateModel validateModel){


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