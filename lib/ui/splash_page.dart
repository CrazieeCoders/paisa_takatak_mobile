import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
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
      ),
    );
  }
}
