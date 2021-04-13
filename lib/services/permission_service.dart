import 'package:permission_handler/permission_handler.dart';

class PermissionsService{


   Future<bool> checkPermission() async{

    Map<Permission,PermissionStatus> statuses = await [
      Permission.camera,
      Permission.phone,
      Permission.sms,
      Permission.storage,
    ].request();

    if(statuses[Permission.camera].isGranted){
      if(statuses[Permission.phone].isGranted){
        if(statuses[Permission.sms].isGranted){
          if(statuses[Permission.storage].isGranted) {
            return true;
          }
        }
      }

    }
   return false;
  }


}