import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/loading_Indicator.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_event.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_state.dart';



class SplashPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
        create: (context)=>SplashBloc()..add(AuthEvent()),
        child: SplashPage());
  }
}



class SplashPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc,SplashState>(
        listener:(context,state){
          if(state is SignedInState){
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(context,'/poiPage', (route) => false);
          }else if(state is DocumentuploadSuccessState){
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(context,'/loanForm', (route) => false);
          }else if(state is LoanAgrementState){
            LoadingDialog.hide(context);
            Navigator.pushNamedAndRemoveUntil(context,'/loanConfirmation', (route) => false);
          }else if(state is SplashLoadingState){
            LoadingDialog.show(context);
          }
        } ,
        child: BlocBuilder<SplashBloc,SplashState>(
          builder: (context,state){
            if(state is NotSignedInState){
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Style.paleYellow,
                          Style.palePurple
                        ]
                    )
                ),
                child: Stack(
                  children: [
                    Center(child: Image.asset('cutouts/login-signup/logo@1x.png')),
                    Positioned(
                      bottom: 16.0,
                      right: 36.0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context,'/signUp', (route) => false);
                        },
                        child: Container(
                          height: 50.0,
                          width: 156,
                          decoration: BoxDecoration(
                            color: Style.inkBlueColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text('Login',
                                style:Style.button2TextStyle
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16.0,
                      left: 36.0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context,'/signUp', (route) => false);
                        },
                        child: Container(
                          height: 50.0,
                          width: 156,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color:Style.inkBlueColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text('Sign Up',
                              style: Style.button1TextStyle,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Style.paleYellow,
                        Style.palePurple
                      ]
                  )
              ),
              child: Stack(
                children: [
                  Center(child: Image.asset('cutouts/login-signup/logo@1x.png')),
                ],
              ),
            );
          },

        ),
      ),
    );
  }
}
