import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/loanAgreement_bloc/loanAgreement_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loaform_event.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loanform_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loanform_state.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/model/registeration_model.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';


class LoanFormProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
         BlocProvider<LoanFormBloc>(
            create: (context)=>LoanFormBloc(),),
          BlocProvider<AgreementBloc>(
            create: (context)=>AgreementBloc(),),
        ],

        child: LoanForm());
  }
}


class LoanForm extends StatefulWidget {
  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {

  LoanFormBloc loanFormBloc;
  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;
  int flag =0;


  @override
  Widget build(BuildContext context) {

    loanFormBloc = BlocProvider.of<LoanFormBloc>(context);


    return MultiBlocListener(
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



        BlocListener<LoanFormBloc,LoanFormState>(


          listener: (context,state){
            if(state is LoanFormSuccessState){
              LoadingDialog.hide(context);
              Navigator.pushNamedAndRemoveUntil(context,'/loanDetailForm', (route) => false,
              );
            }else if(state is LoanFormLoadingState){
              LoadingDialog.show(context);
            }else if(state is LoanFormFailureState){
              LoadingDialog.hide(context);
              Fluttertoast.showToast(msg: "Failed to update",
                  toastLength: Toast.LENGTH_LONG
              );
            }
          },

        ),


      ],

        child: Scaffold(
          appBar: AppBar(
            title: Text('Loan Application Form', style: Style.appBarStyle),
            backgroundColor: Style.paleYellow,
            elevation: 0.0,
            centerTitle: true,
          /*  leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('cutouts/verify-otp/Icon-Arrow-Left@1.5x.png')),*/
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
                padding: EdgeInsets.fromLTRB(w*3.91, 0.0, w*3.91, h*1.95),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      Center(
                          child: Padding(
                        padding:  EdgeInsets.only(top: 2.43*h, bottom: 3.41*h),
                        child: Text(
                          'Complete the Loan Application',
                          style: Style.subHeaderTextStyle,
                        ),
                      )),
                      AppForm(context,loanFormBloc),
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

Widget AppForm(BuildContext context,LoanFormBloc loanFormBloc) {


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
  SharedPrefs sharedPrefs =SharedPrefs();


  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  return Form(
    key: _formKey,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
        padding: EdgeInsets.only(left: 4.86*w, bottom: 1.21*h),
        child: Text(
          'Loan Amount',
          style: Style.desc2TextStyle,
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w, bottom: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 6.89*h,
            width: 87.59*w,
            child: TextFormField(
              controller: loanAmountController,
              keyboardType: TextInputType.number,
              style: Style.input1TextStyle,
              inputFormatters: [
                 LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                suffixText: 'Max 1.5 Lakhs',
                suffixStyle: Style.suffixTextStyle,
                border: InputBorder.none,
              ),
              validator: (amount) {

                if(amount.isEmpty){
                  return "Please enter the loan amount";
                }else if(int.parse(amount) < 100){
                  return "Please enter Loan amount lesser than 100 Rs";
                }else if (int.parse(amount) > 150000) {
                  return "Please enter the loan amount less than 1.5 lakhs";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Text('Loan Tenure(in Months)', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 6.89*h,
            width: 87.59*w,
            child: TextFormField(
              controller: loanTenureController,
              keyboardType: TextInputType.number,
              style: Style.input1TextStyle,
              inputFormatters: [
                new LengthLimitingTextInputFormatter(2),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                suffixText: 'Max 60 Months',
                suffixStyle: Style.suffixTextStyle,
                border: InputBorder.none,
              ),
              validator: (month) {
                if(month.isEmpty){
                  return "Please enter the loan tenure";
                }else if(int.parse(month) < 1){
                  return "Please enter loan tenure greater than 1 month";
                }else if (int.parse(month) > 60) {
                  return "Please enter the loan tenure less than 60 months";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w, top: 1.21*h),
        child: Text('Rate of Interest of 12.5% applicable annually',
            style: Style.descTextStyle),
      ),
      SizedBox(height: 3.65*h),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w),
        child: Text('General Information', style: Style.header1TextStyle),
      ),
      SizedBox(
        height: 2.43*h,
      ),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w),
        child: Text('Full Name of the Applicant', style: Style.desc2TextStyle),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              enabled: false,
              readOnly: true,
              textCapitalization: TextCapitalization.sentences,
              controller: nameTextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                //  FilteringTextInputFormatter. digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                border: InputBorder.none,
                  hintText: '${sharedPrefs.getUserName}',
                  hintStyle: Style.input2TextStyle
              ),
           /*   validator: (value) {
                if (value.isEmpty || value == '') {
                  return "Please enter your name";
                }else if(value.length < 3){
                  return "Please enter a valid name";
                }
                return null;
              },*/
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(left:4.86*w,top: 1.21*h),
        child: Text('Primary Contact Number', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: EdgeInsets.only(left:4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              enabled: false,
              readOnly: true,
              controller: phTextController,
              keyboardType: TextInputType.phone,
              style: Style.input2TextStyle,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                  border: InputBorder.none,
                hintText: '${sharedPrefs.getPhone}',
                hintStyle: Style.input2TextStyle
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w, top: 1.21*h),
        child: Text('Secondary Contact Number *', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: EdgeInsets.only(left:4.86*w, top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              controller: ph2TextController,
              keyboardType: TextInputType.phone,
              style: Style.input2TextStyle,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                border: InputBorder.none,
                //  suffixIcon: Image.asset('cutouts/POIPOA/help-icon@1x.png')
              ),
              validator: (ph) {
                if(ph ==''){
                return "Please enter the secondary contact number";
                }else if (ph.length != 10) {
                  return "Please enter a valid number";
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w, top: 1.21*h),
        child: Text('Permanent Address', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              enabled: false,
              readOnly: true,
              textCapitalization: TextCapitalization.sentences,
              controller: addr1TextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                //  FilteringTextInputFormatter. digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                border: InputBorder.none,
                  hintText: '${sharedPrefs.getPermanentAddress}',
                  hintStyle: Style.input2TextStyle
              ),
             /* validator: (value) {
                if (value.isEmpty || value == '') {
                  return "Please enter a permanent address.";
                }else if(value.length <3){
                  return 'Please enter a valid address';
                }
                return null;
              },*/
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w,),
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top:1.94*w),
                child: Text(
                  'Area pin : ',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 1.46*h, color: Color(0xFF7371FC)),
                ),
              ),
            ),
            Card(
              elevation: 1.0,
              child: Padding(
                padding:EdgeInsets.only(left:1.94*w),
                child: Container(
                  height: 5.67*h,
                  width:68.89*w,
                  child: TextFormField(
                    enabled: false,
                    readOnly: true,
                    controller: pin1TextController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontFamily: 'Roboto Bold',
                        fontSize: 1.70*h,
                        color: Color(0xFF7371FC)),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      contentPadding:EdgeInsets.fromLTRB(1.94*w,0.97*h,1.94*w,0.97*h),
                      border: InputBorder.none,
                        hintText: '${sharedPrefs.getPinCode}',
                        hintStyle: Style.input2TextStyle
                    ),
               /*     validator: (value) {
                      if (value.isEmpty || value == '') {
                        return "Please enter the area pin.";
                      }else if(value.length !=6){
                        return "Please enter a valid pin";
                      }
                      return null;
                    },*/
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w,top:1.21*h),
        child: Text('Local Address', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: addr2TextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                //  FilteringTextInputFormatter. digitsOnly
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value.isEmpty || value == '') {
                  return "Please enter the local address";
                }else if(value.length < 3){
                  return 'Please enter a valid address';
                }
                return null;
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w),
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top:0.97*h),
                child: Text(
                  'Area pin : ',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontSize: 1.46*h, color: Color(0xFF7371FC)),
                ),
              ),
            ),
            Card(
              elevation: 1.0,
              child: Container(
                height: 5.67*h,
                width:68.89*w,
                child: TextFormField(
                  controller: pin2TextController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontFamily: 'Roboto Bold',
                      fontSize: 1.70*h,
                      color: Color(0xFF7371FC)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(1.94*w,0.97*h,1.94*w,0.97*h),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value.isEmpty || value == '') {
                      return "Please enter the Area pin";
                    }else if(value.length != 6){
                      return "Please enter a valid pin";
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
        padding: EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Text('PAN Card', style: Style.desc2TextStyle),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              enabled: false,
              readOnly: true,
              controller: panTextController,
              keyboardType: TextInputType.text,
              style: Style.input2TextStyle,
              inputFormatters: [
                UpperCaseTextFormatter(),
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                border: InputBorder.none,
                  hintText: '${sharedPrefs.getPanNumber}',
                  hintStyle: Style.input2TextStyle
              ),
            /*  validator: (value) {
                if(value == ''){
                return "Please enter your PAN Card number";
                }else if (!RegExp(r'^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$').hasMatch(value)) {
                  return "Please enter a valid PAN card number";
                }
                return null;
              },*/
            ),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Text('UID Number', style: Style.desc2TextStyle),
      ),
      Padding(
        padding:  EdgeInsets.only(left: 4.86*w,top: 1.21*h),
        child: Card(
          elevation: 1.0,
          child: Container(
            height: 5.67*h,
            width: 87.59*w,
            child: TextFormField(
              enabled: false,
              readOnly: true,
              controller: uidTextController,
              keyboardType: TextInputType.number,
              style: Style.input2TextStyle,
              inputFormatters: [
                maskFormatter,
                LengthLimitingTextInputFormatter(14),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                border: InputBorder.none,
                  hintText: '${sharedPrefs.getUidNumber}',
                  hintStyle: Style.input2TextStyle
              ),
          /*    validator: (value) {
                 if(value == ''){
                return 'Please enter your UID';
                }else if (value.length != 14) {
                  return "Please enter a valid UID";
                }
                return null;
              },*/
            ),
          ),
        ),
      ),
      SizedBox(height: 2.43*h,),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(3.89*w,1.95*h,3.89*w,1.95*h),
              child: GestureDetector(
                onTap: (){

                  if(_formKey.currentState.validate()) {

                    RegisterationInfo register =
                    RegisterationInfo(
                      alternatePhNum:ph2TextController.text,
                      loanAmount: loanAmountController.text,
                      loanTenure: loanTenureController.text,
                      localAddress: addr2TextController.text,
                      panNumber: panTextController.text,
                      permanentAddr: addr1TextController.text,
                      phNum: sharedPrefs.getPhone,
                      pinCode: pin1TextController.text,
                      uidNumber: uidTextController.text,
                      userName: nameTextController.text,
                    );

                    loanFormBloc.add(AddLoanFormEvent(registerationInfo:register));
                  }
                },
                child: Container(
                  height: 6.09*h,
                  width: 72.01*w,
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


