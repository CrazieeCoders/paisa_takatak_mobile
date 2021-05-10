import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paisa_takatak_mobile/Widgets/countDown_Timer.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/notifications.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paisa_takatak_mobile/bloc/renewLoanBloc/renew_loan_event.dart';
import 'package:paisa_takatak_mobile/bloc/renewLoanBloc/renewLoan_state.dart';
import 'package:paisa_takatak_mobile/bloc/renewLoanBloc/renewLoan_bloc.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';

class RenewLoanProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RenewLoanBloc>(
        create: (context) => RenewLoanBloc(), child: RenewLoan());
  }
}

class RenewLoan extends StatefulWidget {
  @override
  _RenewLoanState createState() => _RenewLoanState();
}

class _RenewLoanState extends State<RenewLoan> {
  int flag = 0;
  bool checkBoxValue = false;
  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  RenewLoanBloc _renewLoanBloc;
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    _renewLoanBloc = BlocProvider.of<RenewLoanBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Renew Loan', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              // _scaffoldKey.currentState.openDrawer();
            },
            child: Container(
                height: 5.31 * h,
                width: 7.03 * w,
                child: Image.asset('cutouts/home/burger-menu@1.5x.png'))),
        actions: [
          SizedBox(
            width: 6.94 * w,
          ),
          GestureDetector(
              onTap: () {
                UserNotification.show(context);
              },
              child: Container(
                  height: 7.31 * h,
                  width: 8.03 * w,
                  child: Image.asset('cutouts/home/notification-icon@2x.png'))),
          GestureDetector(
              child: Container(
                  height: 7.31 * h,
                  width: 10.03 * w,
                  child: Image.asset('cutouts/home/help-icon@2x.png')))
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is ConnectionFailure) {
                flag = 1;
                InternetConnectivity.show(context);
              } else if (state is ConnectionSuccess) {
                if (flag == 1) {
                  InternetConnectivity.hide(context);
                }
              }
            },
          ),
          BlocListener<RenewLoanBloc, RenewOtpState>(
            listener: (context, state) {
              if (state is RenewOtpSuccessState) {
                Fluttertoast.showToast(
                    msg:'Loan Application success', toastLength: Toast.LENGTH_LONG);
              } else if (state is RenewOtpFailureState) {
                Fluttertoast.showToast(
                    msg: "Invalid OTP !!", toastLength: Toast.LENGTH_LONG);
              } else if (state is RenewOtpLoadingState) {
                LoadingDialog.show(context);
              } else if (state is RenewOtpErrorState) {
                LoadingDialog.hide(context);
                Fluttertoast.showToast(
                    msg: state.errMsg, toastLength: Toast.LENGTH_LONG);
              } else if (state is RenewResendOtpSuccessState) {
                LoadingDialog.hide(context);
              } else {
                LoadingDialog.hide(context);
              }
            },
          ),
        ],
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Style.paleYellow,
                    Style.palePurple,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(w * 3.91, 0.0, w * 3.91, h * 1.95),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 4.21*h,
                    ),
                    Center(
                      child: Text(
                        'Congratulations !!',
                        style: Style.headerTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.43 * w),
                            child: Container(
                                height: 7.31 * h,
                                width: 8.03 * w,
                                child: Image.asset(
                                    'cutouts/home/confirm-icon-blue@1.5x.png')),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.72 * w),
                            child: Text('xxxx xxxx 1578'),
                          ),
                          SizedBox(
                            width: 36.92 * w,
                          ),
                          Icon(Icons.arrow_drop_down_sharp),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.40*h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                      child: Row(
                        children: [
                          Container(
                            height: 20.63 * h,
                            width: 39.06 * w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Style.placeHolderColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 0.36 * h,
                                  ),
                                  Container(
                                      height: 7.31 * h,
                                      width: 9.03 * w,
                                      child: Image.asset(
                                          'cutouts/home/rupee-filled-icon@1.5x.png')),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.72 * w, 0.36 * h, 0.72 * w, 0.36 * h),
                                    child: Text(
                                      '23,438',
                                      style: Style.input1TextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.72 * w, 0.36 * h, 0.72 * w, 0.36 * h),
                                    child: Text('Total OutStanding',
                                        style: Style.desc2TextStyle),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.72 * w, 0.36 * h, 0.72 * w, 0.36 * h),
                                    child: Text(
                                      'Total 33,438',
                                      style: Style.input2TextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3.64 * w,
                          ),
                          Container(
                            height: 20.63 * h,
                            width: 39.06 * w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Style.placeHolderColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 7.31 * h,
                                      width: 9.03 * w,
                                      child: Image.asset(
                                          'cutouts/RenewLoan/add-amount-icon@2x.png')),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.72 * w, 0.36 * h, 0.72 * w, 0.36 * h),
                                    child: Text(
                                      '10,000',
                                      style: Style.input1TextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.72 * w, 0.36 * h, 0.72 * w, 0.36 * h),
                                    child: Text('1st EMI 05-06-21',
                                        style: Style.desc2TextStyle),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.72 * w, 0.36 * h, 0.72 * w, 0.36 * h),
                                    child: Text(
                                      'Tenture 36 mo',
                                      style: Style.input2TextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.42 * h),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w),
                      child: Text(
                        'Agreement Statement',
                        style: Style.header1TextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 2.43 * h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                      child: Card(
                        elevation: 1.0,
                        child: Container(
                          height: 18.95 * h,
                          width: 48.66 * w,
                          color: Style.paleYellow,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.95 * h,
                    ),
                    Card(
                      elevation: 1.0,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 2.43 * h, bottom: 2.43 * h, left: 4.86 * w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: checkBoxValue,
                                      onChanged: (bool value) {
                                        setState(() {
                                          checkBoxValue = value;
                                        });
                                      }),
                                  Wrap(
                                    children: [
                                      Text(
                                          'I have read Terms & Conditions and Agree to it ',
                                          style: Style.checkBoxTextStyle),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 9.73 * w),
                                child: Text('by providing OTP',
                                    style: Style.checkBoxTextStyle),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<RenewLoanBloc, RenewOtpState>(
                      builder: (context, state) {
                        if (state is RenewSendOtpState||state is RenewOtpFailureState||state is RenewOtpSuccessState||state is RenewOtpErrorState||state is RenewSendOtpState||state is RenewResendOtpSuccessState) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 1.95 * h,
                              ),
                              Center(
                                child: Text(
                                  'Please enter the 4 digit OTP number received on ',
                                  style: Style.descTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 1.95 * h,
                              ),
                              sharedPrefs.getPhone != null
                                  ? Center(
                                      child: Text(
                                        '+91 ${sharedPrefs.getPhone}',
                                        style: Style.desc1TextStyle,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        '+91  ',
                                        style: Style.desc1TextStyle,
                                      ),
                                    ),
                              SizedBox(
                                height: 2.43 * h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 9.24 * w, right: 6.81 * w),
                                child: OtpForm(
                                    phNo: sharedPrefs.getPhone,
                                    checkBox: checkBoxValue),
                              ),
                              SizedBox(
                                height: 4.26 * h,
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            3.89 * w,
                            1.95 * h,
                            3.89 * w,
                            1.95 * h,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (checkBoxValue) {
                                _renewLoanBloc.add(RenewSendOtpEvent());
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please accept the terms and conditions",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              }
                            },
                            child: Container(
                              height: 6.09 * h,
                              width: 72.01 * w,
                              decoration: BoxDecoration(
                                  color: Style.inkBlueColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                child: Text(
                                  'Get OTP',
                                  style: Style.button2TextStyle,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  String phNo;
  bool checkBox;

  OtpForm({this.phNo, this.checkBox});

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with TickerProviderStateMixin {
  AnimationController _controller;
  StepTween _stepTween;
  RenewLoanBloc _renewLoanBloc;

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();

  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  int flag = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 3),
    )..forward();

    _stepTween = StepTween(
      begin: 3 * 60,
      end: 0,
    )..animate(_controller).addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _renewLoanBloc.add(RenewResendOtpEvent(phNo: widget.phNo));
          _controller.reset();
          _controller.forward();
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    _renewLoanBloc = BlocProvider.of<RenewLoanBloc>(context);

    String verifyOtpMethod() {
      String pin;

      if (_formKey.currentState.validate()) {
        pin =
            '${pin1Controller.text}${pin2Controller.text}${pin3Controller.text}${pin4Controller.text}';
        _formKey.currentState.reset();

        pin1Controller.clear();
        pin2Controller.clear();
        pin3Controller.clear();
        pin4Controller.clear();

        return pin;
      }
    }

    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is ConnectionFailure) {
          flag = 1;
          InternetConnectivity.show(context);
        } else if (state is ConnectionSuccess) {
          if (flag == 1) {
            InternetConnectivity.hide(context);
          }
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 12.16 * w,
                  child: TextFormField(
                    controller: pin1Controller,
                    autofocus: true,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                    ],
                    style: TextStyle(
                      fontSize: 2.43 * h,
                    ),
                    textAlign: TextAlign.center,
                    decoration: Style.otpInputDecoration,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 12.16 * w,
                  child: TextFormField(
                    controller: pin2Controller,
                    focusNode: pin2FocusNode,
                    style: TextStyle(
                      fontSize: 2.43 * h,
                    ),
                    textAlign: TextAlign.center,
                    decoration: Style.otpInputDecoration,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin3FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 12.16 * w,
                  child: TextFormField(
                    controller: pin3Controller,
                    focusNode: pin3FocusNode,
                    style: TextStyle(
                      fontSize: 2.43 * h,
                    ),
                    textAlign: TextAlign.center,
                    decoration: Style.otpInputDecoration,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      nextField(value: value, focusNode: pin4FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 12.16 * w,
                  child: TextFormField(
                    controller: pin4Controller,
                    focusNode: pin4FocusNode,
                    style: TextStyle(
                      fontSize: 2.43 * h,
                    ),
                    textAlign: TextAlign.center,
                    decoration: Style.otpInputDecoration,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      pin4FocusNode.unfocus();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.82 * h,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resend OTP :',
                    style: Style.descTextStyle,
                  ),
                  Countdown(
                    animation: _stepTween.animate(_controller),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 11.58 * h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                3.89 * w,
                1.95 * h,
                3.89 * w,
                1.95 * h,
              ),
              child: GestureDetector(
                onTap: () {
                  if (widget.checkBox) {
                    String pin = verifyOtpMethod();

                    if (pin.isEmpty || pin == null || pin == "") {
                      Fluttertoast.showToast(msg: "Please enter OTP");
                    } else {
                      _renewLoanBloc.add(
                          RenewVerifyOtpEvent(pin: pin, phNo: widget.phNo));
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please accept the terms and conditions",
                      toastLength: Toast.LENGTH_LONG,
                    );
                  }
                },
                child: Container(
                  height: 6.09 * h,
                  width: 72.01 * w,
                  decoration: BoxDecoration(
                      color: Style.inkBlueColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      'Verify with OTP',
                      style: Style.button2TextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
