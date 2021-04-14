import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/ui/loan_agreement.dart';
import 'package:paisa_takatak_mobile/ui/loan_confirmation.dart';
import 'package:paisa_takatak_mobile/ui/loan_detail_form.dart';
import 'package:paisa_takatak_mobile/ui/loan_form.dart';
import 'package:paisa_takatak_mobile/ui/payment_page.dart';
import 'package:paisa_takatak_mobile/ui/poi_page.dart';
import 'package:paisa_takatak_mobile/ui/signup_page.dart';
import 'package:paisa_takatak_mobile/ui/splash_page.dart';
import 'package:paisa_takatak_mobile/ui/verify_otp.dart';
import 'Themes/size_config.dart';
import 'Widgets/internet_connectivity.dart';
import 'bloc/network_bloc/network_event.dart';
import 'data/sharedPref.dart';



Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefs().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        return  OrientationBuilder(
          builder: (context,orientation){
            SizeConfig().init(constraints,orientation);
            return BlocProvider<NetworkBloc>(
              create: (context)=>NetworkBloc()..add(ListenConnection()),
              child: MaterialApp(
                title: 'Paisa Takatak',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.indigo,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                routes: {
                  '/':(context) =>SplashPageProvider(),
                  '/signUp':(context) => SignUpPageProvider(),
                  '/verifyOtp':(context) => VerifyOtp(),
                  '/poiPage':(context) =>POIPageProvider(),
                  '/loanForm':(context) =>LoanFormProvider(),
                  '/loanDetailForm':(context) =>LoanDetailFormProvider(),
                  '/loanAgreement':(context) =>LoanAgreementFormProvider(),
                  '/loanConfirmation':(context) =>LoanConfirmation(),
                  '/paymentPage':(context) =>PaymentPageProvider(),
                },

              ),
            );
          },

        );
      },
    );
  }
}

