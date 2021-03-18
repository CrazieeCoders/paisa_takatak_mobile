import 'package:http/http.dart' as http;
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';

class APIService{

  static String baseUrl = 'http://13.232.165.118:885';
  static String baseUrl1 = 'http://13.232.165.118:8085/swagger-ui.html#/';


   generateOtp(String ph) async{

    var res = await  http.post(baseUrl+'/otp/generate?number=$ph');

    _returnResponse(res);

  }

  static _returnResponse(http.Response response){
     print("Status code : ${response.statusCode}");

   switch(response.statusCode){
     case 200:
       print('${response.body}');
       return response.body;
     break;
     case 201:
       throw ModelException(msg: response.body);
     break;
     case 401:
       throw UnAuthorizedException(msg: response.body);
       break;
     case 403:
       throw ForbiddenException(msg: response.body);
       break;
     case 404:
       throw NotFoundException(msg: response.body);
       break;

     default:
       throw FetchOtpException(msg: "Error occurred while communicating with server");
       break;
   }

  }


}