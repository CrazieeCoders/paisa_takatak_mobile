import 'package:http/http.dart' as http;
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';
import 'package:paisa_takatak_mobile/model/otp_model.dart';
import 'package:paisa_takatak_mobile/model/uploadFiles_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';

class APIService{

  static String baseUrl = 'http://13.232.165.118:8085';
  static String baseUrl1 = 'http://13.232.165.118:8085/swagger-ui.html#/';
  static String authorizationToken ='';

  Response response;
  Dio dio = new Dio();


   Future<String> generateOtp(String ph) async{

    var res = await  http.post(baseUrl+'/otp/generate?number=$ph');

    print('${res.body}');

    final  otpModel = otpModelFromJson(res.body);
    authorizationToken = otpModel.responseObject.token;
    String otp = _returnResponse(otpModel);

    otp = utf8.decode(base64.decode(otpModel.responseObject.encyPass));

     return otp;
  }


   uploadFilesAndImages({String ph,File file,String fileName}) async{


     var request = http.MultipartRequest('POST',Uri.parse(baseUrl+'/uploadDocs/uploadCustomerFile/'));

     request.headers['Authorization'] =authorizationToken;
     request.fields['fileName'] = fileName;
     request.fields['number'] =ph;
     
    // request.files.add(await http.MultipartFile.fromPath('files', file.path));

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

    /* FormData formData = FormData.fromMap({
       "fileName": "fileName",
       "number": ph,
       "files": await MultipartFile.fromFile(file.path,filename: "MyPhoto.jpg"),
     });

      response = await dio.post(baseUrl+'/uploadDocs/uploadCustomerFile/', data: formData,
        options: Options(
          headers: {
            'Authorization': authorizationToken,
          },
        ),
      );

      print('${response.data}');*/
   //  final validateModel = validateModelFromJson(response.data);

   _returnResponse1(validateModel);
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