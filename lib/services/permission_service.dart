import 'package:permission_handler/permission_handler.dart';

class PermissionsService{


   checkPermission() async{

    Map<Permission,PermissionStatus> statuses = await [
      Permission.camera,
      Permission.phone,
      Permission.sms,
    ].request();

    if(statuses[Permission.camera].isGranted){
      if(statuses[Permission.phone].isGranted){
        if(statuses[Permission.sms].isGranted){

        return true;

        }
      }

    }


  }


}