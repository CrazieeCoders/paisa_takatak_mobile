import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/Widgets/notifications.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmiDetail extends StatefulWidget {
  @override
  _EmiDetailState createState() => _EmiDetailState();
}

class _EmiDetailState extends State<EmiDetail> {
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
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toastMessage(
        "Payment Failure");

    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toastMessage("External Wallet" + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Details', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('cutouts/verify-otp/Icon-Arrow-Left@1.5x.png')),
        actions: [
          SizedBox(
            width: 6.94 * w,
          ),
          GestureDetector(
              onTap: () {
                UserNotification.show(context);
              },
              child: Container(
                  height: 7.31 * h,
                  width: 8.03 * w,
                  child: Image.asset('cutouts/home/notification-icon@2x.png'))),
          GestureDetector(
              child: Container(
                  height: 7.31 * h,
                  width: 10.03 * w,
                  child: Image.asset('cutouts/home/help-icon@2x.png')))
        ],
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
            padding: EdgeInsets.fromLTRB(w * 3.91, 0.0, w * 3.91, h * 1.95),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2.43 * w),
                          child: Container(
                              height: 7.31 * h,
                              width: 8.03 * w,
                              child: Image.asset(
                                  'cutouts/home/confirm-icon-blue@1.5x.png')),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.72 * w),
                          child: Text('xxxx xxxx 1578'),
                        ),
                        SizedBox(
                          width: 36.92 * w,
                        ),
                        Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Container(
                      height: 25.63 * h,
                      width: 39.06 * w,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 2.77 * w, top: 2.80 * h),
                            child: Text('Loan Outstanding',
                                style: Style.desc2TextStyle),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 2.77 * w),
                                child: Container(
                                    height: 6.31 * h,
                                    width: 9.03 * w,
                                    child: Image.asset(
                                        'cutouts/home/rupee-outlined-icon@1.5x.png')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.77 * w),
                                child: Text(
                                  '27,408',
                                  style: Style.input1TextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 2.77 * w, left: 11.23 * h),
                                child: Text(
                                  'EMI 3/36',
                                  style: Style.input2TextStyle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.80 * h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.77 * w),
                            child: Text('Loan Amount',
                                style: Style.desc2TextStyle),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 2.77 * w),
                                child: Container(
                                    height: 6.31 * h,
                                    width: 9.03 * w,
                                    child: Image.asset(
                                        'cutouts/home/rupee-filled-icon@1.5x.png')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.77 * w),
                                child: Text(
                                  '30,000',
                                  style: Style.input1TextStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 2.77 * w, left: 11.23 * h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/renewLoan',
                                      (route) => false,
                                    );
                                  },
                                  child: Container(
                                    height: 4.09 * h,
                                    width: 15.01 * w,
                                    decoration: BoxDecoration(
                                        color: Style.inkBlueColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
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
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Container(
                      height: 10.63 * h,
                      width: 39.06 * w,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Style.placeHolderColor,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 2.77 * w, top: 1.40 * h),
                            child: Text('Next Due Date',
                                style: Style.desc2TextStyle),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 2.77 * w),
                                child: Container(
                                    height: 5.00 * h,
                                    width: 7.03 * w,
                                    child: Image.asset(
                                        'cutouts/loandetails/calender-blue-icon@2x.png')),
                              ),
                              Text(
                                '05/03/2021',
                                style: Style.desc4TextStyle,
                              ),
                              SizedBox(
                                width: 33.33 * w,
                              ),
                              GestureDetector(
                                onTap: () {
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
                                  height: 4.09 * h,
                                  width: 15.01 * w,
                                  decoration: BoxDecoration(
                                      color: Style.inkBlueColor,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text(
                                      'Pay Now',
                                      style: Style.smallButton2TextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1st EMI Due Date', style: Style.desc2TextStyle),
                        Text('Last EMI Due Date', style: Style.desc2TextStyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('05/01/21', style: Style.desc3TextStyle),
                        Text('05/01/24', style: Style.desc3TextStyle),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Container(
                      height: 1.40 * h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(Colors.green),
                        value: 3 / 33,
                        //  minHeight: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.40 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('3 EMI Paid', style: Style.desc3TextStyle),
                        Text('33 EMI Pending', style: Style.desc3TextStyle),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan ID', style: Style.desc4TextStyle),
                        Text(
                          'SCH14578',
                          style: Style.input3TextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan A/C', style: Style.desc4TextStyle),
                        Text(
                          '4587 4785 4590',
                          style: Style.input3TextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.43 * h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.86 * w, right: 4.86 * w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Disbursement Date', style: Style.desc4TextStyle),
                        Text(
                          '01/01/21',
                          style: Style.input3TextStyle,
                        ),
                      ],
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

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }
}
