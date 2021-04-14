import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/bloc/payment_bloc/payment_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/payment_bloc/payment_events.dart';
import 'package:paisa_takatak_mobile/bloc/payment_bloc/payment_state.dart';



class PaymentPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
        create: (context)=>PaymentBloc(),
        child: PaymentPage());
  }
}



class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  String _chosenValue;
  var maskFormatter = new MaskTextInputFormatter(mask: '#### #### ####', filter: { "#": RegExp(r'[0-9]') });

  TextEditingController cardController = TextEditingController();

  PaymentBloc _paymentBloc;


  @override
  Widget build(BuildContext context) {
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
        centerTitle: true,
        /* leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('cutouts/verify-otp/Icon-Arrow-Left@1.5x.png')),*/
      ),
      body:  Stack(
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
                          'Enter the Amount',
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
                             // controller: _amountTextController,
                              keyboardType: TextInputType.number,
                              style: Style.input2TextStyle,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(2.43*w,1.21*h,2.43*w,1.21*h),
                                suffixStyle: Style.suffixTextStyle,
                                border: InputBorder.none,
                              ),
                              validator: (amount) {
                                if (amount.isEmpty || amount == '') {
                                  return 'please enter the amount';
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
                          'Choose Payment Option',
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
                            'Credit Card/Debit Card',
                            'Net Banking',
                            'Upi Payment',
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
                              "Please choose an Payment Option",
                              style: Style.dropdownTextStyle,
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenValue = value;
                            });

                          _paymentBloc.add(SelectPayment(payment: _chosenValue));
                          },
                        ),
                      ),


                      BlocBuilder<PaymentBloc,PaymentState>(
                        builder: (context,state){
                         if(state is CardState) {
                           return Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: EdgeInsets.only(
                                     left: 4.86 * w, top: 1.21 * h),
                                 child: Text('Card Number',
                                     style: Style.desc2TextStyle),
                               ),
                               Padding(
                                 padding: EdgeInsets.only(
                                     left: 4.86 * w, top: 1.21 * h),
                                 child: Card(
                                   elevation: 1.0,
                                   child: Container(
                                     height: 5.67 * h,
                                     width: 87.59 * w,
                                     child: TextFormField(
                                       controller: cardController,
                                       keyboardType: TextInputType.number,
                                       style: Style.input2TextStyle,
                                       inputFormatters: [
                                         maskFormatter,
                                         LengthLimitingTextInputFormatter(14),
                                       ],
                                       decoration: InputDecoration(
                                         contentPadding: EdgeInsets.fromLTRB(
                                             2.43 * w, 1.21 * h, 2.43 * w,
                                             1.21 * h),
                                         border: InputBorder.none,
                                         prefixIcon: Icon(
                                             Icons.credit_card_outlined),
                                         //r suffixIcon: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                                       ),
                                       validator: (value) {
                                         if (value == '') {
                                           return 'Please enter your UID.';
                                         } else if (value.length != 14) {
                                           return "Please enter a valid UID.";
                                         }
                                         return null;
                                       },
                                     ),
                                   ),
                                 ),
                               ),
                               SizedBox(height: 2.43 * h,),
                             ],
                           );
                         }else if(state is NetBankingState){
                           return Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: EdgeInsets.only(
                                     left: 4.86 * w, top: 1.21 * h),
                                 child: Text('Net Banking',
                                     style: Style.desc2TextStyle),
                               ),
                               Padding(
                                 padding: EdgeInsets.only(
                                     left: 4.86 * w, top: 1.21 * h),
                                 child: Card(
                                   elevation: 1.0,
                                   child: Container(
                                     height: 5.67 * h,
                                     width: 87.59 * w,
                                     child: TextFormField(
                                       controller: cardController,
                                       keyboardType: TextInputType.number,
                                       style: Style.input2TextStyle,
                                       inputFormatters: [
                                         maskFormatter,
                                         LengthLimitingTextInputFormatter(14),
                                       ],
                                       decoration: InputDecoration(
                                         contentPadding: EdgeInsets.fromLTRB(
                                             2.43 * w, 1.21 * h, 2.43 * w,
                                             1.21 * h),
                                         border: InputBorder.none,
                                         prefixIcon: Icon(
                                             Icons.home_filled),
                                         //r suffixIcon: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                                       ),
                                       validator: (value) {
                                         if (value == '') {
                                           return 'Please enter your UID.';
                                         } else if (value.length != 14) {
                                           return "Please enter a valid UID.";
                                         }
                                         return null;
                                       },
                                     ),
                                   ),
                                 ),
                               ),
                               SizedBox(height: 2.43 * h,),
                             ],
                           );
                         }else if(state is UpiState){
                           return Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(30.0,0.0,0.0,0.0),
                                 child: Container(
                                     height:140,
                                     width: 70,
                                     child: Image.asset('cutouts/payment/gpay.png')),
                               ),

                               Padding(
                                 padding: const EdgeInsets.fromLTRB(30.0,0.0,0.0,0.0),
                                 child: Container(
                                     height:140,
                                     width: 70,
                                     child: Image.asset('cutouts/payment/phonepay.png')),
                               ),

                               Padding(
                                 padding: const EdgeInsets.fromLTRB(30.0,0.0,0.0,0.0),
                                 child: Container(
                                     height:140,
                                     width: 70,
                                     child: Image.asset('cutouts/payment/upipay.png')),
                               ),
                             ],
                           );
                         }

                         return SizedBox();
                        },
                      ),


                      Padding(
                        padding:  EdgeInsets.only(
                            left: 9.73*w, right: 9.73*w, top: 39.51*h, bottom: 2.43*h),
                        child: GestureDetector(
                          onTap: (){


                              if (_chosenValue == null) {
                                Fluttertoast.showToast(msg: "please select the Payment Option", toastLength: Toast.LENGTH_SHORT);
                              } else {

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
                                'Proceed With Payment',
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
    );
  }
}
