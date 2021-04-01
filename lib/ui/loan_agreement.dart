import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paisa_takatak_mobile/Widgets/countDown_Timer.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/loanAgreement_bloc/loanAgreement_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/loanAgreement_bloc/loanAgreement_event.dart';
import 'package:paisa_takatak_mobile/bloc/loanAgreement_bloc/loanAgreement_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';


class LoanAgreementFormProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AgreementBloc>(
      create: (context)=>AgreementBloc(),
        child: LoanAgreementForm());
  }
}



class LoanAgreementForm extends StatefulWidget {
  @override
  _LoanAgreementFormState createState() => _LoanAgreementFormState();
}

class _LoanAgreementFormState extends State<LoanAgreementForm> {

  bool checkBoxValue = false;
  SharedPrefs sharedPrefs = SharedPrefs();
  APIService apiService = APIService();



  @override
  Widget build(BuildContext context) {

    return BlocListener<AgreementBloc,AgreementOtpState>(
    listener: (context,state) {
      if (state is AgreementOtpSuccessState) {
        Navigator.pushNamedAndRemoveUntil(
          context, '/loanConfirmation', (route) => false,
        );
      } else if (state is AgreementOtpFailureState) {
        print("Came inside OTp Failure State");
        Fluttertoast.showToast(msg: "Invalid OTP !!",
            toastLength: Toast.LENGTH_LONG
        );
      } else if (state is AgreementOtpLoadingState) {
        LoadingDialog.show(context);
      } else if (state is AgreementOtpErrorState) {
        LoadingDialog.hide(context);
        Fluttertoast.showToast(msg: state.errMsg,
            toastLength: Toast.LENGTH_LONG
        );
      } else if (state is AgreementResendOtpSuccessState) {
        LoadingDialog.hide(context);
      } else {
        print("came inside else method");
        LoadingDialog.hide(context);
      }

    },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Loan Agreement OTP Sign', style: Style.appBarStyle),
          backgroundColor: Style.paleYellow,
          elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 20.0,),
                    Center(
                    child: Text(
                      'Sign Loan Agreement with OTP',
                      style: Style.headerTextStyle,
                    ),
                  ),
                  SizedBox(height:28.0),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Text('Agreement Statement',
                      style: Style.header1TextStyle,),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20.0),
                      child: Card(
                        elevation: 1.0,
                        child: Container(
                          height: 180,
                          width: 200,
                          color:Style.paleYellow,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Card(
                      elevation: 1.0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0,bottom: 20.0,left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [
                                  Checkbox(
                                      value: checkBoxValue,
                                      onChanged:(bool value){
                                        setState(() {
                                          checkBoxValue = value;
                                        });
                                      }),

                                  Wrap(
                                   children: [
                                     Text('I have read Terms & Conditions and Agree to it ',
                                         style:Style.checkBoxTextStyle ),
                                   ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:40.0),
                                child: Text('by providing OTP',
                                  style:Style.checkBoxTextStyle),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0,),

                    Center(
                      child: Text('Please enter the 4 digit OTP number received on ',
                      style: Style.descTextStyle,),
                    ),
                    SizedBox(height: 16.0,),

                    sharedPrefs.getPhone!= null?
                    Center(
                      child: Text('+91 ${sharedPrefs.getPhone}',
                        style: Style.desc1TextStyle,),
                    ):
                    Center(
                      child: Text('+91  ',
                        style: Style.desc1TextStyle,),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:38.0,right: 28.0),
                      child: OtpForm(phNo: sharedPrefs.getPhone,checkBox:checkBoxValue),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}



class OtpForm extends StatefulWidget {

  String phNo;
  bool checkBox;

  OtpForm ({this.phNo,this.checkBox});

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> with TickerProviderStateMixin{


  AnimationController _controller;
  StepTween _stepTween;
  AgreementBloc _agreementBloc;
  SharedPrefs sharedPrefs = SharedPrefs();

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
        _agreementBloc.add(AgreementResendOtpEvent(phNo: widget.phNo));
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
    _agreementBloc = BlocProvider.of<AgreementBloc>(context);

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


                if(widget.checkBox) {
                  sharedPrefs.setLoanStatus(1);

                  String pin = verifyOtpMethod();

                  _agreementBloc.add(AgreementVerifyOtpEvent(pin: pin,phNo:widget.phNo));

                }else{
                  Fluttertoast.showToast(msg: "Please accept the terms and conditions",
                    toastLength: Toast.LENGTH_LONG,
                  );
                }






              },
              child: Container(
                height: 50.0,
                width: 296.0,
                decoration: BoxDecoration(
                    color: Style.inkBlueColor,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Center(child: Text('Verify with OTP',
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