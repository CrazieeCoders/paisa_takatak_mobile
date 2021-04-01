import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/countDown_Timer.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_Bloc.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_events.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_states.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';



class VerifyOtp extends StatefulWidget{
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {

  @override
  Widget build(BuildContext context) {

    final Arguments args = ModalRoute.of(context).settings.arguments;

    return BlocProvider<SignUpBloc>(
      create: (context)=>SignUpBloc(),
      child: Scaffold(
          appBar: AppBar(
            title:  Text('Change mobile number?',
                style:Style.appBarStyle
            ),
            backgroundColor: Style.paleYellow,
            elevation: 0.0,
            centerTitle: true,
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset('cutouts/verify-otp/Icon-Arrow-Left@1.5x.png')),
        ),
        body: BlocListener<SignUpBloc,OtpState>(
          listener: (context,state){
            if(state is OtpSuccessState){
              Navigator.pushNamedAndRemoveUntil(context,'/poiPage', (route) => false,
              );
            }else if(state is OtpFailureState){
              print("Came inside OTp Failure State");
              Fluttertoast.showToast(msg: "Invalid OTP !!",
                  toastLength: Toast.LENGTH_LONG
              );
            }else if(state is OtpLoadingState){
              LoadingDialog.show(context);
            }else if(state is OtpErrorState){
              LoadingDialog.hide(context);
              Fluttertoast.showToast(msg: state.errMsg,
                  toastLength: Toast.LENGTH_LONG
              );
            }else if(state is ResendOtpSuccessState){
              LoadingDialog.hide(context);
            }else{
              print("came inside else method");
              LoadingDialog.hide(context);
            }
          },
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
                ),),
                 Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child:ListView(
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          Center(child: Image.asset('cutouts/verify-otp/Banner@1x.png')),
                          Center(
                            child: Text('Verify OTP',
                            style: Style.headerTextStyle,
                            ),
                          ),
                          SizedBox(height: 16.0,),
                          Center(
                            child: Text('Please enter the 4-digit OTP number received on',
                            style: Style.descTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Center(
                            child: Text('+91 ${args.phoneNo}',
                            style: Style.desc1TextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:38.0,right: 28.0),
                            child: OtpForm(phNo: args.phoneNo,),
                          ),


                        ],
                      ),

                  ),
                ),
            ],
          ),
        ),
      ),
    );


  }

}


class OtpForm extends StatefulWidget {

  String phNo;

  OtpForm ({this.phNo});

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with TickerProviderStateMixin{


  AnimationController _controller;
  StepTween _stepTween;
  SignUpBloc _signUpBloc;

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    _controller = AnimationController(vsync: this,
      duration: Duration(minutes: 3),
    )..forward();


    _stepTween = StepTween(
      begin: 3 * 60,
      end: 0, 
    )..animate(_controller).addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _signUpBloc.add(ResendOtpEvent(phNo: widget.phNo));
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

  void nextField({String value,FocusNode focusNode}){

    if(value.length == 1){
      focusNode.requestFocus();
    }

  }


  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    String verifyOtpMethod(){

      String pin;

      if(_formKey.currentState.validate()) {
        pin = '${pin1Controller.text}${pin2Controller.text}${pin3Controller
            .text}${pin4Controller.text}';
        _formKey.currentState.reset();
        return pin;

      }

    }

    return Form(
      key: _formKey,
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: pin1Controller,
                  autofocus: true,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(1),
                  ],
                  style: TextStyle(fontSize: 20.0,),
                  textAlign: TextAlign.center,
                  decoration: Style.otpInputDecoration,
                  keyboardType: TextInputType.phone,
                  onChanged: (value){
                    nextField(value: value,focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: pin2Controller,
                  focusNode: pin2FocusNode,
                  style: TextStyle(fontSize: 20.0,),
                  textAlign: TextAlign.center,
                  decoration: Style.otpInputDecoration,
                  keyboardType: TextInputType.phone,
                  onChanged: (value){
                    nextField(value: value,focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: pin3Controller,
                  focusNode: pin3FocusNode,
                  style: TextStyle(fontSize: 20.0,),
                  textAlign: TextAlign.center,
                  decoration: Style.otpInputDecoration,
                  keyboardType: TextInputType.phone,
                  onChanged: (value){
                    nextField(value: value,focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: pin4Controller,
                  focusNode: pin4FocusNode,
                  style: TextStyle(fontSize: 20.0,),
                  textAlign: TextAlign.center,
                  decoration: Style.otpInputDecoration,
                  keyboardType: TextInputType.phone,
                  onChanged: (value){
                    pin4FocusNode.unfocus();
                  },
                ),
              ),
            ],
          ),

          SizedBox(
            height: 15.0,
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Resend OTP :',
                  style: Style.descTextStyle,),
                Countdown(
                  animation: _stepTween.animate(_controller),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 95.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: (){

                String pin = verifyOtpMethod();

                _signUpBloc.add(VerifyOtpEvent(pin: pin,phNo:widget.phNo));


              },
              child: Container(
                height: 50.0,
                width: 296.0,
                decoration: BoxDecoration(
                    color: Style.inkBlueColor,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Center(child: Text('Verify OTP',
                  style: Style.button2TextStyle,
                ),

                ),
              ),
            ),
          ),
        ],
      ),
    );



  }




}
