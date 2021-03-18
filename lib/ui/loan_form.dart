import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';

class LoanForm extends StatefulWidget {
  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Application Form', style: Style.appBarStyle),
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
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 28.0),
                    child: Text(
                      'Complete the Loan Application',
                      style: Style.subHeaderTextStyle,
                    ),
                  )),
                  AppForm(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget AppForm(BuildContext context) {
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController loanTenureController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phTextController = TextEditingController();
  TextEditingController ph2TextController = TextEditingController();
  TextEditingController addr1TextController = TextEditingController();
  TextEditingController pin1TextController = TextEditingController();
  TextEditingController addr2TextController = TextEditingController();
  TextEditingController pin2TextController = TextEditingController();
  TextEditingController panTextController = TextEditingController();
  TextEditingController uidTextController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(mask: '#### #### ####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();


  return Form(
    key: _formKey,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
        child: Text(
          'Loan Amount',
          style: Style.desc2TextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: loanAmountController,
              keyboardType: TextInputType.number,
              style: Style.input1TextStyle,
              inputFormatters: [
                 LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                suffixText: 'Max 1.5Lakhs',
                suffixStyle: Style.suffixTextStyle,
                border: InputBorder.none,
              ),
              validator: (amount) {

                if(amount.isEmpty){
                  return null;
                }else if (int.parse(amount) > 150000) {
                  return "Loan amount cannot be greater than 1.5lakhs";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Text('Loan Tenure(in Months)', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: loanTenureController,
              keyboardType: TextInputType.number,
              style: Style.input1TextStyle,
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                suffixText: 'Max 60Months',
                suffixStyle: Style.suffixTextStyle,
                border: InputBorder.none,
              ),
              validator: (month) {
                if(month.isEmpty){
                  return null;
                }else if (int.parse(month) > 60) {
                  return "Number of Months cannot exceed 60";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Text('Rate of Interest of 12.5% applicable annually',
            style: Style.descTextStyle),
      ),
      SizedBox(height: 30.0,),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text('General Information', style: Style.header1TextStyle),
      ),
      SizedBox(
        height: 20.0,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text('Full Name of the Applicant', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: nameTextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                //  FilteringTextInputFormatter. digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value.isEmpty || value == '') {
                  return "Name cannot be empty";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left:20.0,top: 10.0),
        child: Text('Primary Contact Number', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left:20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: phTextController,
              keyboardType: TextInputType.phone,
              style: Style.input2TextStyle,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
              validator: (ph) {
                if (ph.length != 10) {
                  return "Invalid Number";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Text('Secondary Contact Number *', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: ph2TextController,
              keyboardType: TextInputType.phone,
              style: Style.input2TextStyle,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5.0),
                  border: InputBorder.none,
                  suffixIcon: Image.asset('cutouts/POIPOA/help-icon@1x.png')),
              validator: (ph) {
                if (ph.length != 10) {
                  return "Invalid Number";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Text('Permanent Address', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: addr1TextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                //  FilteringTextInputFormatter. digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value.isEmpty || value == '') {
                  return "Address cannot be empty";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,),
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(
                  'Area PIN:',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 12.0, color: Color(0xFF7371FC)),
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              child: Container(
                height: 36.5,
                width: 80.0,
                child: TextFormField(
                  controller: pin1TextController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontFamily: 'Roboto Bold',
                      fontSize: 14.0,
                      color: Color(0xFF7371FC)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom:5.0),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value.isEmpty || value == '') {
                      return "Pin cannot be Empty";
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Text('Local Address', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: addr2TextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                //  FilteringTextInputFormatter. digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value.isEmpty || value == '') {
                  return "Address cannot be empty";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Text(
                  'Area PIN:',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 12.0, color: Color(0xFF7371FC)),
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              child: Container(
                height: 36.5,
                width: 80.0,
                child: TextFormField(
                  controller: pin2TextController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontFamily: 'Roboto Bold',
                      fontSize: 14.0,
                      color: Color(0xFF7371FC)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom:5.0),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value.isEmpty || value == '') {
                      return "Pin cannot be Empty";
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Text('PAN Card', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: panTextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                UpperCaseTextFormatter(),
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (!RegExp(r'^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$').hasMatch(value)) {
                  return "Invalid Pan Card";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Text('UID Number', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 46.5,
            width: 360.0,
            child: TextFormField(
              controller: uidTextController,
              keyboardType: TextInputType.number,
              style: Style.input2TextStyle,
              inputFormatters: [
                maskFormatter,
                LengthLimitingTextInputFormatter(14),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
                suffixIcon: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
              ),
              validator: (value) {
                if (value.length != 14) {
                  return "Invalid UID";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      SizedBox(height: 20.0,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: (){
                  if(_formKey.currentState.validate()){
                      Navigator.pushNamedAndRemoveUntil(context,'/poiPage', (route) => false);
                  }
                 //   Navigator.pushNamedAndRemoveUntil(context,'/poiPage', (route) => false);
                },
                child: Container(
                  height: 50.0,
                  width: 296.0,
                  decoration: BoxDecoration(
                      color: Style.inkBlueColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Center(child: Text('Verify & Submit',
                    style: Style.button2TextStyle,
                  ),

                  ),
                ),
              ),
            ),
          ),
    ]),
  );
}

class UpperCaseTextFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection
    );
  }
}


