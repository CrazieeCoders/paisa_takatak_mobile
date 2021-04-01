import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_Bloc.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_events.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_states.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/services/permission_service.dart';
import 'package:fluttertoast/fluttertoast.dart';



class SignUpPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context)=>SignUpBloc(),
        child: SignUpPage());
  }
}


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  PermissionsService permissionsService = PermissionsService();
  TextEditingController _phTextController = TextEditingController();
  FocusNode _phTextFocus;
  SignUpBloc _signUpBloc;

  final _formKey = GlobalKey<FormState>();
  bool isPermissionGiven = false;


  getPermissions() async {
    isPermissionGiven = await permissionsService.checkPermission();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermissions();
    _phTextFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phTextFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text('',
            style:Style.appBarStyle
        ),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
      ),
      body: BlocListener<SignUpBloc,OtpState>(
        listener: (context,state){
          if(state is SendOtpState){
            LoadingDialog.hide(context);
            Navigator.pushNamed(context,
                '/verifyOtp',
                arguments: Arguments(
                    phoneNo: state.sendOtp));
          }else if(state is OtpErrorState){
            LoadingDialog.hide(context);
            Fluttertoast.showToast(msg: state.errMsg,
            toastLength: Toast.LENGTH_LONG
            );
          }else if(state is OtpLoadingState){
            LoadingDialog.show(context);
          }else{
            LoadingDialog.hide(context);
          }
        },
        child: BlocBuilder<SignUpBloc,OtpState>(
          builder: (context,state){
              return Stack(
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

                          Stack(

                            children: <Widget>[

                                     Padding(
                                       padding: const EdgeInsets.only(left:50.0),
                                       child: Card(
                                        elevation: 1.0,
                                        child: Container(
                                          height: 56.5,
                                          width: 70.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              '+ 91 ',
                                              style:  Style.prefixTextStyle,
                                            ),
                                          ),
                                        ),
                                    ),
                                     ),


                              Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:120.0),
                                  child: Card(
                                    elevation: 1.0,
                                    child: Container(
                                      height: 56.5,
                                      width: 216.0,
                                      child: TextFormField(
                                        controller: _phTextController,
                                        focusNode: _phTextFocus,
                                        keyboardType: TextInputType.phone,
                                        style: Style.phoneTextStyle,
                                        inputFormatters: [
                                          new LengthLimitingTextInputFormatter(10),
                                        ],
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left:20.0),

                                            border: InputBorder.none
                                        ),
                                        onChanged: (value){
                                          if(value.length == 10){
                                            _phTextFocus.unfocus();
                                          }
                                        },
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
                            ],
                          ),


                          SizedBox(
                            height: 75.5,
                          ),

                          GestureDetector(
                            onTap: ()async{
                              if(_formKey.currentState.validate()) {

                                if (_phTextController.text.length == 10) {
                                  if (isPermissionGiven) {

                                    _signUpBloc.add(SendOtpEvent(phNo: _phTextController.text));

                                    _phTextController.clear();

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
              );

          },

        ),
      ),
    );
  }
}
