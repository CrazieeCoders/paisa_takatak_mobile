import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmiPage extends StatefulWidget {

  GlobalKey<ScaffoldState> key;

  EmiPage({this.key});

  @override
  _EmiPageState createState() => _EmiPageState();
}

class _EmiPageState extends State<EmiPage> {

  int flag = 0;

  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  SharedPrefs _prefs = SharedPrefs();

  Razorpay _razorpay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    toastMessage("Payment Success" + response.paymentId);

    toastMessage("Order Successfully Placed");
   // Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toastMessage(
        "Payment Failure");

   // Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toastMessage("External Wallet" + response.walletName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NetworkBloc, NetworkState>(
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
                      SizedBox(height: 2.43*h,),

                      Padding(
                        padding:  EdgeInsets.only(left:4.86*w,right: 4.86*w),
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left:2.43*w),
                              child: Container(
                                  height: 7.31 * h,
                                  width: 8.03 * w,
                                  child:
                                  Image.asset('cutouts/home/confirm-icon-blue@1.5x.png')),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left:0.72*w),
                              child: Text('xxxx xxxx 1578'),
                            ),
                            SizedBox(width: 36.92*w,),
                           Icon(Icons.arrow_drop_down_sharp),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 2.43*h,
                      ),
                      Center(
                          child: Text('Last Visited 12-01-2021 01:21 PM',
                              style: Style.desc2TextStyle)),
                      SizedBox(
                        height: 3.65*h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.86*w, right: 4.86*w),
                        child: Row(
                          children: [
                            Container(
                              height: 20.63 * h,
                              width: 39.06 * w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Style.placeHolderColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0.36*h,
                                    ),
                                    Container(
                                        height: 7.31 * h,
                                        width: 9.03 * w,
                                        child:
                                        Image.asset('cutouts/home/rupee-filled-icon@1.5x.png')),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.72*w,0.36*h,0.72*w,0.36*h),
                                      child: Text('30,000',
                                        style: Style.input1TextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.72*w,0.36*h,0.72*w,0.36*h),
                                      child: Text('Total OutStanding',
                                          style: Style.desc2TextStyle
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.72*w,0.36*h,0.72*w,0.36*h),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamedAndRemoveUntil(context,'/renewLoan', (route) => false,
                                          );
                                        },
                                        child: Container(
                                          height: 3.09 * h,
                                          width: 15.01 * w,
                                          decoration: BoxDecoration(
                                              color: Style.inkBlueColor,
                                              borderRadius: BorderRadius.circular(5.0)),
                                          child: Center(
                                            child: Text(
                                              'Renew',
                                              style: Style.smallButton2TextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.64*w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/emiDetailPage');
                              },
                              child: Container(
                                height: 20.63 * h,
                                width: 39.06 * w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Style.placeHolderColor,
                                  ),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                       Container(
                                          height: 7.31 * h,
                                          width: 9.03 * w,
                                          child:
                                          Image.asset('cutouts/home/rupee-outlined-icon@1.5x.png')),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.72*w,0.36*h,0.72*w,0.36*h),
                                        child: Text('1,049',
                                          style: Style.input1TextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.72*w,0.36*h,0.72*w,0.36*h),
                                        child: Text('Due Date 05-03-21',
                                            style: Style.desc2TextStyle),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0.72*w,0.36*h,0.72*w,0.36*h),
                                        child: Text('EMI 3/36',
                                          style: Style.input2TextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.43*h,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            var options = {
                              //testkey
                              'key': 'rzp_test_lBIPHgjcPs1lk5',
                              //  'key': 'rzp_live_GFEf91Ekzuy7ZY',
                              'amount': 5 * 100,
                              'name': 'Paisa Takatak',
                              'currency': "INR",
                              'theme.color': "#55f7c9",
                              'description': 'EMI ',
                              'prefill': {
                                'contact': _prefs.getPhone,
                                'email': '',
                              },
                              'external': {
                                'wallets': ['paytm']
                              }
                            };

                            try {
                              _razorpay.open(options);
                            } catch (e) {
                              debugPrint(e);
                            }
                          },

                          child: Container(
                            height: 7.09 * h,
                            width: 82.01 * w,
                            decoration: BoxDecoration(
                                color: Style.inkBlueColor,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text(
                                'Pay Now',
                                style: Style.button2TextStyle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.65*h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.86*w),
                            child: Text(
                              'Last 2 Transactions',
                              style: Style.dropdownTextStyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 4.86*w),
                            child: Text('ALL PAYMENTS',
                                style: Style.desc2TextStyle),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.43*h,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 4.86*w, right: 4.86*w),
                        child: Container(
                          height: 7.63 * h,
                          width: 39.06 * w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Style.placeHolderColor,
                            ),
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:2.43*w),
                                  child: Container(
                                  height: 7.31 * h,
                                  width: 8.03 * w,
                                  child:
                                  Image.asset('cutouts/home/confirm-outlined-icon@1.5x.png')),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:1.21*w),
                                  child: Text('1,047'),
                                ),
                                SizedBox(width: 24.33*w,),
                                Text('EMI Paid on 05-02-21',
                                    style: Style.desc2TextStyle
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.43*h,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:4.86*w, right:4.86*w),
                        child: Container(
                          height: 7.63 * h,
                          width: 39.06 * w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Style.placeHolderColor,
                            ),
                              borderRadius: BorderRadius.circular(5.0)
                          ),

                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:2.43*w),
                                  child: Container(
                                      height: 7.31 * h,
                                      width: 8.03 * w,
                                      child:
                                      Image.asset('cutouts/home/confirm-outlined-icon@1.5x.png')),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left:1.21*w),
                                  child: Text('1,047'),
                                ),
                                SizedBox(width: 24.33*w,),
                                Text('EMI Paid on 05-02-21',
                                    style: Style.desc2TextStyle
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }
}
