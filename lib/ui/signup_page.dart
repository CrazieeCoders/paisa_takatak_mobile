import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/services/permission_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PermissionsService permissionsService = PermissionsService();
  TextEditingController _phTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPermissionGiven = false;
  APIService apiService = APIService();

  getPermissions() async {
    isPermissionGiven = await permissionsService.checkPermission();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('',
            style:Style.appBarStyle
        ),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Style.paleYellow,
                    Style.palePurple,
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Container(
              width: 400,
              height: 720,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: ListView(
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
                  Center(
                    child: Text('Please enter your Mobile number to continue',
                      style: Style.textStyle1,
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),

                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0,right: 32.0),
                      child: Card(
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
                    ),
                  ),
                  SizedBox(
                    height: 75.5,
                  ),

                  GestureDetector(
                    onTap: ()async{
                      if(_formKey.currentState.validate()) {

                           if (_phTextController.text.length == 10) {
                             if (isPermissionGiven) {


                               try {
                            //    await apiService.generateOtp(_phTextController.text);

                                 Navigator.pushNamed(context,
                                     '/verifyOtp',
                                     arguments: Arguments(
                                         phoneNo: _phTextController.text));
                                 _phTextController.clear();

                               }catch(e){
                                 print('Came inside catch bloc');
                                 if(e is ModelException){
                                   Fluttertoast.showToast(msg: 'Model Exception');
                                 }else if(e is ForbiddenException){
                                   Fluttertoast.showToast(msg: 'Forbidden Url Site');
                                 }else if(e is UnAuthorizedException){
                                   Fluttertoast.showToast(msg: 'UnAuthorized Site');
                                 }else if(e is FetchOtpException){
                                   Fluttertoast.showToast(msg: 'Unable to communicate with server');
                                 }else if (e is NotFoundException){
                                   Fluttertoast.showToast(msg:'Url not found');
                                 }else{
                                   Fluttertoast.showToast(msg:'Unable to communicate with server');
                                 }
                               }

                             } else {
                               getPermissions();
                             }
                           }


                         }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:38.0,right: 38.0),
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
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
