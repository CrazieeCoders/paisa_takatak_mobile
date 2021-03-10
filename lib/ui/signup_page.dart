import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/widgets.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';
import 'package:paisa_takatak_mobile/services/permission_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  PermissionsService permissionsService = PermissionsService();
  TextEditingController _phTextController = TextEditingController();

  final  _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissionsService.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Style.paleYellow,
            Style.palePurple,
          ]
        )

      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0,36.0,16.0,24.0),
          child: Container(
                color: Colors.white,
              child: Column(
                 children: [
                   SizedBox(
                     height: 56.0,
                   ),
                   Container(
                     height: 336,
                     width: 265,
                     child: Image.asset('cutouts/enter-mobile/banner@1x.png'),
                   ),
                   SizedBox(
                     height: 50.0,
                   ),
                   Text('Please enter your Mobile number to continue',
                     style: Style.textStyle1,
                   ),
                   SizedBox(
                     height: 60.0,
                   ),

                       Card(
                         elevation: 1.0,
                         child: Container(
                           height: 56.5,
                           width: 236.0,
                           child: TextFormField(
                             controller: _phTextController,
                             keyboardType: TextInputType.phone,
                             style: Style.phoneTextStyle,
                             inputFormatters: [
                               new LengthLimitingTextInputFormatter(10),
                             ],
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.all(5.0),
                                 prefixText: "+91 |  ",
                                 prefixStyle: Style.prefixTextStyle,
                                 border: InputBorder.none
                             ),
                             validator: (phNo){
                               if(phNo.length != 10){
                                 return "Please enter valid Phone Number";
                               }
                               return null;
                             },
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 75.5,
                       ),

                       GestureDetector(
                         onTap: (){
                           if(_formKey.currentState.validate()) {
                             print('${_phTextController.text}');
                             if (_phTextController.text.length == 10) {
                               Navigator.pushNamed(context,
                                   '/verifyOtp',
                                   arguments: Arguments(
                                       phoneNo: _phTextController.text));
                               _phTextController.clear();
                             } else {
                               Fluttertoast.showToast(
                                   msg: 'invalid Number',
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Style.inkBlueColor,
                                   textColor: Style.whiteColor,
                                   fontSize: 14.0
                               );
                             }
                           }
                         },
                         child: Container(
                           height: 50.0,
                           width: 296.0,
                           decoration: BoxDecoration(
                               color: Style.inkBlueColor,
                               borderRadius: BorderRadius.circular(5.0)
                           ),
                           child: Center(child: Text('Continue',
                             style: Style.button2TextStyle,
                           ),

                           ),
                         ),
                       )
                 ],
              ),
            ),
          ),
      ),
      );
  }
}
