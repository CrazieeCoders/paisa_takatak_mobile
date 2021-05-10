import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/bloc/emi_bloc/emi_bloc.dart';
import 'file:///C:/Users/jsurulir/AndroidStudioProjects/arsey/paisa_takatak_mobile/lib/bloc/emi_bloc/emi_event.dart';
import 'file:///C:/Users/jsurulir/AndroidStudioProjects/arsey/paisa_takatak_mobile/lib/bloc/emi_bloc/emi_state.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/bank_stat_bloc/bank_stat_bloc.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/model/household_model.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';




class LoanDetailFormProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmiBloc>(create: (context) => EmiBloc()),
      ],
      child: LoanDetailForm(),
    );
  }
}

class LoanDetailForm extends StatefulWidget {
  @override
  _LoanDetailFormState createState() => _LoanDetailFormState();
}

class _LoanDetailFormState extends State<LoanDetailForm> {
  String _chosenValue;

  EmiBloc emiBloc;

  SharedPrefs sharedPrefs = SharedPrefs();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _noOfDependentsController = TextEditingController();
  TextEditingController _1StEmiController = TextEditingController();
  TextEditingController _2ndEmiController = TextEditingController();
  TextEditingController _3rdEmiController = TextEditingController();
  TextEditingController _monthlyIncomeController = TextEditingController();
  TextEditingController _householdExpenseController = TextEditingController();


  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;


  @override
  Widget build(BuildContext context) {

    emiBloc = BlocProvider.of<EmiBloc>(context);
    int flag =0;


    return Scaffold(
      appBar: AppBar(
        title: Text('Household Details', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
        centerTitle: true,
       /* leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('cutouts/verify-otp/Icon-Arrow-Left@1.5x.png')),*/
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

      BlocListener<EmiBloc,EmiState>(
        listener: (context,state){
          if(state is EmiLoadingState){
            LoadingDialog.show(context);
          }else if(state is EmiSuccessState){
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
              context, '/loanAgreement', (route) => false,
            );
          }else if (state is EmiFailureState){
            LoadingDialog.hide(context);
            Fluttertoast.showToast(msg: "Failed to update server",
                toastLength: Toast.LENGTH_LONG
            );
          }
        },),



        ],
          child: Form(
            key: _formKey,
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
                  padding: EdgeInsets.fromLTRB(3.89*w, 0.0, 3.89*w, 1.95*h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.86*w, bottom: 1.21*h, top: 3.65*h),
                              child: Text(
                                'Number of Dependents',
                                style: Style.desc2TextStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                   EdgeInsets.only(left: 4.86*w, bottom: 1.21*h),
                              child: Card(
                                elevation: 1.0,
                                child: Container(
                                  height: 5.67*h,
                                  width: 387.59*w,
                                  child: TextFormField(
                                    controller: _noOfDependentsController,
                                    keyboardType: TextInputType.number,
                                    style: Style.input2TextStyle,
                                    inputFormatters: [
                                       LengthLimitingTextInputFormatter(2),
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                      suffixStyle: Style.suffixTextStyle,
                                      border: InputBorder.none,
                                    ),
                                    validator: (amount) {
                                      if (amount.isEmpty || amount == '') {
                                        return 'Please enter the number of dependents';
                                      }else if(int.parse(amount) > 99){
                                        return ' Please enter number of dependents lesser than 100';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(
                                  left: 4.86*w, bottom:1.21*h, top: 1.21*h),
                              child: Text(
                                'Existing EMIs',
                                style: Style.desc2TextStyle,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(
                                  left: 4.86*w, bottom: 1.21*h, right: 17.03*w),
                              child: DropdownButton<String>(
                                focusColor: Colors.white,
                                value: _chosenValue,
                                //elevation: 5,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                items: <String>[
                                  '0',
                                  '1',
                                  '2',
                                  '3',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding:  EdgeInsets.fromLTRB(1.94*w,0.97*h,1.94*w,0.97*h),
                                      child: Text(
                                        value,
                                        style: Style.dropdownTextStyle,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                hint: Padding(
                                  padding:  EdgeInsets.fromLTRB(1.94*w,0.97*h,1.94*w,0.97*h),
                                  child: Text(
                                    "Please choose an EMI ",
                                    style: Style.dropdownTextStyle,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                  emiBloc.add(SelectEmiEvent(emi: _chosenValue));
                                },
                              ),
                            ),
                            BlocBuilder<EmiBloc, EmiState>(
                              builder: (context, state) {
                                if (state is OneEmiState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h, top: 3.65*h),
                                        child: Text(
                                          '1st EMI Amount',
                                          style: Style.desc2TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h),
                                        child: Card(
                                          elevation: 1.0,
                                          child: Container(
                                            height: 5.67*h,
                                            width: 387.59*w,
                                            child: TextFormField(
                                              controller: _1StEmiController,
                                              keyboardType: TextInputType.number,
                                              style: Style.input2TextStyle,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                                suffixStyle: Style.suffixTextStyle,
                                                border: InputBorder.none,
                                              ),
                                              validator: (amount) {
                                                if (amount.isEmpty || amount == '') {
                                                  return 'Please enter the 1st EMI amount';
                                                }else if(int.parse(amount) > 99999){
                                                  return 'Please enter EMI amount lesser than 100000';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (state is TwoEmiState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h, top: 3.65*h),
                                        child: Text(
                                          '1st EMI Amount',
                                          style: Style.desc2TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h),
                                        child: Card(
                                          elevation: 1.0,
                                          child: Container(
                                            height: 5.67*h,
                                            width: 387.59*w,
                                            child: TextFormField(
                                              controller: _1StEmiController,
                                              keyboardType: TextInputType.number,
                                              style: Style.input2TextStyle,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                                suffixStyle: Style.suffixTextStyle,
                                                border: InputBorder.none,
                                              ),
                                              validator: (amount) {
                                                if (amount.isEmpty || amount == '') {
                                                  return 'Please enter the 1st EMI amount';
                                                }else if(int.parse(amount) > 99999){
                                                  return 'Please enter EMI amount lesser than 100000';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom:1.21*h, top:3.65*h),
                                        child: Text(
                                          '2nd EMI Amount',
                                          style: Style.desc2TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h),
                                        child: Card(
                                          elevation: 1.0,
                                          child: Container(
                                            height: 5.67*h,
                                            width: 387.59*w,
                                            child: TextFormField(
                                              controller: _2ndEmiController,
                                              keyboardType: TextInputType.number,
                                              style: Style.input2TextStyle,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                                suffixStyle: Style.suffixTextStyle,
                                                border: InputBorder.none,
                                              ),
                                              validator: (amount) {
                                                if (amount.isEmpty || amount == '') {
                                                  return 'Please enter the 2nd EMI amount';
                                                }else if(int.parse(amount) > 99999){
                                                  return 'Please enter EMI amount lesser than 100000';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }else if(state is ThreeEmiState){
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h, top:3.65*h),
                                        child: Text(
                                          '1st EMI Amount',
                                          style: Style.desc2TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h),
                                        child: Card(
                                          elevation: 1.0,
                                          child: Container(
                                            height: 5.67*h,
                                            width: 387.59*w,
                                            child: TextFormField(
                                              controller: _1StEmiController,
                                              keyboardType: TextInputType.number,
                                              style: Style.input2TextStyle,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                                suffixStyle: Style.suffixTextStyle,
                                                border: InputBorder.none,
                                              ),
                                              validator: (amount) {
                                                if (amount.isEmpty || amount == '') {
                                                  return 'Please enter the 1st EMI amount';
                                                }else if(int.parse(amount) > 99999){
                                                  return 'Please enter the EMI amount lesser than 100000';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h, top:3.65*h),
                                        child: Text(
                                          '2nd EMI Amount',
                                          style: Style.desc2TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h),
                                        child: Card(
                                          elevation: 1.0,
                                          child: Container(
                                            height: 5.67*h,
                                            width: 387.59*w,
                                            child: TextFormField(
                                              controller: _2ndEmiController,
                                              keyboardType: TextInputType.number,
                                              style: Style.input2TextStyle,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                                suffixStyle: Style.suffixTextStyle,
                                                border: InputBorder.none,
                                              ),
                                              validator: (amount) {
                                                if (amount.isEmpty || amount == '') {
                                                  return 'Please enter the 2nd EMI amount';
                                                }else if(int.parse(amount) > 99999){
                                                  return 'Please enter the EMI amount lesser than 100000';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h, top:3.65*h),
                                        child: Text(
                                          '3rd EMI Amount',
                                          style: Style.desc2TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(
                                            left: 4.86*w, bottom: 1.21*h),
                                        child: Card(
                                          elevation: 1.0,
                                          child: Container(
                                            height: 5.67*h,
                                            width: 387.59*w,
                                            child: TextFormField(
                                              controller: _3rdEmiController,
                                              keyboardType: TextInputType.number,
                                              style: Style.input2TextStyle,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                                suffixStyle: Style.suffixTextStyle,
                                                border: InputBorder.none,
                                              ),
                                              validator: (amount) {
                                                if (amount.isEmpty || amount == '') {
                                                  return 'Please enter the 3rd EMI amount';
                                                }else if(int.parse(amount) > 99999){
                                                  return 'Please enter 3rd EMI amount lesser than 100000';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.86*w, bottom: 1.21*h, top:3.65*h),
                              child: Text(
                                'Monthly Income',
                                style: Style.desc2TextStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                   EdgeInsets.only(left:4.86*w, bottom: 1.21*h),
                              child: Card(
                                elevation: 1.0,
                                child: Container(
                                  height: 5.67*h,
                                  width: 387.59*w,
                                  child: TextFormField(
                                    controller: _monthlyIncomeController,
                                    keyboardType: TextInputType.number,
                                    style: Style.input2TextStyle,
                                    inputFormatters: [
                                       LengthLimitingTextInputFormatter(6),
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                      suffixStyle: Style.suffixTextStyle,
                                      border: InputBorder.none,
                                    ),
                                    validator: (amount) {
                                      if (amount.isEmpty || amount == '') {
                                        return 'Please enter the monthly income';
                                      }else if(int.parse(amount) > 999999){
                                        return 'Please enter monthly income lesser than 10 lakh ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.86*w, bottom:1.21*h, top:3.65*h),
                              child: Text(
                                'Household Expense',
                                style: Style.desc2TextStyle,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(left: 4.86*w, bottom: 1.21*h),
                              child: Card(
                                elevation: 1.0,
                                child: Container(
                                  height: 5.67*h,
                                  width: 387.59*w,
                                  child: TextFormField(
                                    controller: _householdExpenseController,
                                    keyboardType: TextInputType.number,
                                    style: Style.input2TextStyle,
                                    inputFormatters: [
                                       LengthLimitingTextInputFormatter(6),
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                      suffixStyle: Style.suffixTextStyle,
                                      border: InputBorder.none,
                                    ),
                                    validator: (amount) {
                                      if (amount.isEmpty || amount == '') {
                                        return 'Please enter the household expense';
                                      }else if(int.parse(amount) > 999999){
                                        return 'Please enter household expense lesser than 10 lakh';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(
                                  left: 9.73*w, right: 9.73*w, top: 19.51*h, bottom: 2.43*h),
                              child: GestureDetector(
                                onTap: (){

                                  if(_formKey.currentState.validate()) {
                                    if (_chosenValue == null) {
                                      Fluttertoast.showToast(msg: "Please select number of EMI's", toastLength: Toast.LENGTH_SHORT);
                                    } else {

                                        String noOfDependents = _noOfDependentsController
                                            .text;
                                        String firstEmi = _1StEmiController.text;
                                        String secondEmi = _2ndEmiController.text;
                                        String thirdEmi = _3rdEmiController.text;
                                        String monthlyIncome = _monthlyIncomeController
                                            .text;
                                        String householdExpense = _householdExpenseController
                                            .text;

                                        if (firstEmi.isEmpty) {
                                          firstEmi = '0';
                                        }
                                        if (secondEmi.isEmpty) {
                                          secondEmi = '0';
                                        }
                                        if (thirdEmi.isEmpty) {
                                          thirdEmi = '0';
                                        }

                                        int income = int.parse(monthlyIncome);
                                        int expense = int.parse(firstEmi)+int.parse(secondEmi)+int.parse(thirdEmi)+int.parse(householdExpense);

                                       if(income < expense) {
                                          Fluttertoast.showToast(
                                            msg: "Monthly income cannot be less than the Expenses",
                                          toastLength: Toast.LENGTH_SHORT);

                                       }else{
                                         HouseHold household = HouseHold(
                                           noOfDependents: noOfDependents,
                                           firstStEmi: firstEmi,
                                           secondNdEmi: secondEmi,
                                           thirdRdEmi: thirdEmi,
                                           monthlyIncome: monthlyIncome,
                                           householdExpense: householdExpense,
                                         );
                                         emiBloc.add(
                                             SubmitEmiEvent(
                                                 houseHold: household));
                                       }


                                    }
                                  }

                                },
                                child: Container(
                                  height: 6.09*h,
                                  width: 72.01*w,
                                  decoration: BoxDecoration(
                                      color: Style.inkBlueColor,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text(
                                      'Verify & Submit',
                                      style: Style.button2TextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

      ),
    );
  }
}

