import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/ui/loan_form.dart';
import 'package:paisa_takatak_mobile/ui/poi_page.dart';
import 'package:paisa_takatak_mobile/ui/signup_page.dart';
import 'package:paisa_takatak_mobile/ui/splash_page.dart';
import 'package:paisa_takatak_mobile/ui/verify_otp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/':(context) =>LoanForm(),
        //'/':(context) =>SplashPage(),
        '/signUp':(context) => SignUpPage(),
        '/verifyOtp':(context) => VerifyOtp(),
        '/poiPage':(context) =>POIPage(),
        '/loanForm':(context) =>LoanForm(),
      },

    );
  }
}

