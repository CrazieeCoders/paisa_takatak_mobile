import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_event.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_state.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';

class SplashPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(AuthEvent()),
        child: SplashPage());
  }
}

class SplashPage extends StatelessWidget {

  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SignedInState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/poiPage', (route) => false);
          } else if (state is HouseHoldFormPageState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/loanDetailForm', (route) => false);
          } else if (state is LoanAgreementPageState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/loanAgreement', (route) => false);
          } else if (state is LoanConfirmPageState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/loanConfirmation', (route) => false);
          } else if (state is LoanAppProcessSuccessState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/emiPage', (route) => false);
          } else if (state is LoanFormPageState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/loanForm', (route) => false);
          } else if (state is DocumentuploadPageState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/poiPage', (route) => false);
          } else if (state is LoanAgrementState) {
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/loanConfirmation', (route) => false);
          } else if (state is SplashLoadingState) {
            LoadingDialog.show(context);
          } else if (state is NotSignedInState) {
            LoadingDialog.hide(context);
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is NotSignedInState) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Style.paleYellow, Style.palePurple])),
                child: Stack(
                  children: [
                    Center(
                        child: Container(
                            height: SizeConfig.heightMultiplier * 36.58,
                            width: SizeConfig.widthMultiplier * 48.66,
                            child: Image.asset('cutouts/login-signup/logo@2x.png'))),
                    Positioned(
                      bottom: 1.95*h,
                      right: 8.75*w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/signUp', (route) => false);
                        },
                        child: Container(
                          height: SizeConfig.heightMultiplier *6.09,
                          width: SizeConfig.widthMultiplier * 38.04,
                          decoration: BoxDecoration(
                            color: Style.inkBlueColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text('Login', style: Style.button2TextStyle),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1.95*h,
                      left: 8.75*w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/signUp', (route) => false);
                        },
                        child: Container(
                          height: SizeConfig.heightMultiplier *6.09,
                          width: SizeConfig.widthMultiplier * 38.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Style.inkBlueColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: Style.button1TextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Scaffold(
                body: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Style.paleYellow, Style.palePurple])),
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(w*3.91, 0.0, w*3.91, h*1.95),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Card(
                            child: Container(
                              height: SizeConfig.heightMultiplier * 9.75,
                              width: SizeConfig.widthMultiplier *19.46,
                              padding: EdgeInsets.fromLTRB(2.9*w,12.0*h,2.9*w,1.46*h),
                              child: CircularProgressIndicator(
                                backgroundColor: Style.palePurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )));
          },
        ),
      ),
    );
  }
}
