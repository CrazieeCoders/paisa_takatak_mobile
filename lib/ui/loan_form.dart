import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
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
                  AppForm(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget AppForm() {

  TextEditingController loanAmountController = TextEditingController();
  TextEditingController loanTenureController = TextEditingController();

  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(right: 276.0, bottom: 10.0),
      child: Text(
        'Loan Amount',
        style: Style.desc2TextStyle,
      ),
    ),
    Card(
      elevation: 1.0,
      child: Container(
        height: 56.5,
        width: 360.0,
        child: TextFormField(
          controller: loanAmountController,
          keyboardType: TextInputType.number,
          style: Style.input1TextStyle,
          inputFormatters: [
            new LengthLimitingTextInputFormatter(6),
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            suffixText: 'Max 1.5Lakhs',
            suffixStyle: Style.suffixTextStyle,
            border: InputBorder.none,
          ),
          validator: (amount) {
            if (int.parse(amount) > 150000) {
              return "Loan amount cannot be greater than 1.5lakhs";
            }
            return null;
          },
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 206.0, bottom: 10.0, top: 10.0),
      child: Text('Loan Tenure(in Months)', style: Style.desc2TextStyle),
    ),
    Card(
      elevation: 1.0,
      child: Container(
        height: 56.5,
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
            if (int.parse(month) > 60) {
              return "Number of Months cannot exceed 60";
            }
            return null;
          },
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top:10.0,right: 120.0),
      child: Text('Rate of Interest of 12.5% applicable annually',
      style: Style.descTextStyle),
    ),

    Padding(
      padding: const EdgeInsets.only(top:30.0,right: 208),
      child: Text('General Information',
      style: Style.header1TextStyle),
    ),

  ]);

}
