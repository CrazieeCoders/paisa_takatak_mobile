import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/countDown_Timer.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';


class VerifyOtp extends StatefulWidget{
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> with TickerProviderStateMixin{

  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this,
    duration: Duration(minutes: 3),
    );
    _controller.forward();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Arguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
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
                      Divider(),
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
                        child: OtpForm(),
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
                             animation: StepTween(
                               begin: 3 * 60,
                               end: 0,
                             ).animate(_controller),
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
                            //startTime();
                            Navigator.pushNamedAndRemoveUntil(context,'/loanForm', (route) => false);

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

              ),
            ),
        ],
      ),
    );


  }

}


class OtpForm extends StatefulWidget {
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {

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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value,FocusNode focusNode}){

    if(value.length == 1){
      focusNode.requestFocus();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 50,
            child: TextFormField(
              controller: pin1Controller,
              autofocus: true,
              style: TextStyle(fontSize: 20.0,),
              textAlign: TextAlign.center,
              decoration: Style.otpInputDecoration,
              keyboardType: TextInputType.number,
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
              keyboardType: TextInputType.number,
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
              keyboardType: TextInputType.number,
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
              keyboardType: TextInputType.number,
              onChanged: (value){
               pin4FocusNode.unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
