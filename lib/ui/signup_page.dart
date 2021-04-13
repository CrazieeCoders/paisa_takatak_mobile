import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_event.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_Bloc.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_events.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_states.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/services/permission_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
      ],
      child: SignUpPage(),
    );
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

    double h = SizeConfig.heightMultiplier;
    double w = SizeConfig.widthMultiplier;

    int flag = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<NetworkBloc,NetworkState>(
            listener: (context,state){

          if(state is ConnectionFailure){
            flag = 1;
            InternetConnectivity.show(context);
          }else if(state is ConnectionSuccess){
              if(flag ==1) {
                InternetConnectivity.hide(context);
              }

          }
        },
            
          ),

          BlocListener<SignUpBloc, OtpState>(
            listener: (context, state) {
              if (state is SendOtpState) {
                LoadingDialog.hide(context);
                Navigator.pushNamed(context, '/verifyOtp',
                    arguments: Arguments(phoneNo: state.sendOtp));
              } else if (state is OtpErrorState) {
                LoadingDialog.hide(context);
                Fluttertoast.showToast(
                    msg: state.errMsg, toastLength: Toast.LENGTH_LONG);
              } else if (state is OtpLoadingState) {
                LoadingDialog.show(context);
              } else {
                LoadingDialog.hide(context);
              }
            },
          ),
        ],
        child: BlocBuilder<SignUpBloc, OtpState>(
          builder: (context, state) {
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
                  padding:
                      EdgeInsets.fromLTRB(w * 3.91, 0.0, w * 3.91, h * 1.95),
                  child: Container(
                    width: 97.32 * w,
                    height: 87.80 * h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 6.8 * h,
                        ),
                        Container(
                          height: 43 * h,
                          width: 60 * w,
                          child:
                              Image.asset('cutouts/enter-mobile/banner@2x.png'),
                        ),
                        SizedBox(
                          height: 6.09 * h,
                        ),
                        Center(
                          child: Text(
                            'Please enter your Mobile number to continue',
                            style: Style.textStyle1,
                          ),
                        ),
                        SizedBox(
                          height: 7.3 * h,
                        ),
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 12.16 * w),
                              child: Card(
                                elevation: 1.0,
                                child: Container(
                                  height: 6.89 * h,
                                  width: 17.03 * w,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        2.9 * w, 12.0, 2.9 * w, 1.46 * h),
                                    child: Text(
                                      '+ 91 ',
                                      style: Style.prefixTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: EdgeInsets.only(left: 29.19 * w),
                                child: Card(
                                  elevation: 1.0,
                                  child: Container(
                                    height: 6.89 * h,
                                    width: 52.55 * w,
                                    child: TextFormField(
                                      controller: _phTextController,
                                      focusNode: _phTextFocus,
                                      keyboardType: TextInputType.phone,
                                      style: Style.phoneTextStyle,
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(
                                            10),
                                      ],
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 4.86 * w),
                                          border: InputBorder.none),
                                      onChanged: (value) {
                                        if (value.length == 10) {
                                          _phTextFocus.unfocus();
                                        }
                                      },
                                      validator: (phNo) {
                                        if (phNo.length != 10) {
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
                          height: 9.20 * h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              if (_phTextController.text.length == 10) {
                                if (isPermissionGiven) {
                                  _signUpBloc.add(SendOtpEvent(
                                      phNo: _phTextController.text));

                                  _phTextController.clear();
                                } else {
                                  getPermissions();
                                }
                              }
                            }
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 13 * w, right: 9.24 * w),
                            child: Container(
                              height: 6.09 * h,
                              width: 72.01 * w,
                              decoration: BoxDecoration(
                                  color: Style.inkBlueColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                child: Text(
                                  'Continue',
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
