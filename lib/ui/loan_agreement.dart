import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';


class LoanAgreementForm extends StatefulWidget {
  @override
  _LoanAgreementFormState createState() => _LoanAgreementFormState();
}

class _LoanAgreementFormState extends State<LoanAgreementForm> {

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Center(
                    child: Text('+91 9790348843',
                      style: Style.desc1TextStyle,),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:38.0,right: 28.0),
                    child: OtpForm(),
                  ),
                  SizedBox(
                    height: 65.0,
                  ),


                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: (){
                        //startTime();
                        Navigator.pushNamedAndRemoveUntil(context,'/loanConfirmation', (route) => false);

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
            ),
          )

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