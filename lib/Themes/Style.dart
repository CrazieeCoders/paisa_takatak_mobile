import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';

class Style{

  Style._();

  static const Color inkBlueColor = const Color(0xFF1B1C77);
  static const Color whiteColor = const Color(0xFFFFFFFF);
  //static const Color paleYellow = const Color(0xFFFFBE69);
  static const Color paleYellow = Colors.greenAccent;
  //static const Color palePurple = const Color(0xFFAA7DFF);
  static const Color palePurple = Colors.yellow;
  static const Color blackTextColor = const Color(0xFF686868);
  static const Color placeHolderColor = const Color(0xFFBDBDBD);
  static const Color onclickBorderColor = const Color(0xFFFB9090);
  static const Color palePinkColor = const Color(0xFFFFC7C7);
  static const Color darkPinkColor = const Color(0xFFB73C3C);



  static double h = SizeConfig.heightMultiplier;
  static double w = SizeConfig.widthMultiplier;


  static final TextStyle button1TextStyle =TextStyle(
    fontFamily:'Poppins',
     color: Style.inkBlueColor,
     fontSize: 1.95*h,
  );

  static final TextStyle button2TextStyle =TextStyle(
      color:whiteColor,
      fontFamily:'Poppins',
       fontSize:1.95*h,
     decoration: TextDecoration.none

  );

  static final TextStyle smallButton2TextStyle =TextStyle(
      color:whiteColor,
      fontFamily:'Poppins',
      fontSize:1.25*h,
      decoration: TextDecoration.none

  );


  static final TextStyle textStyle1 =TextStyle(
      color:blackTextColor,
      fontFamily:'Roboto',
      fontSize: 1.70*h,
      decoration: TextDecoration.none
  );

  static final TextStyle prefixTextStyle = TextStyle(
     fontFamily: 'Poppins',
     fontSize: 2.43*h,
     color: const Color(0xFF4F4F4F),
    letterSpacing: 1.0,
   // height: 22.0
  );

  static final TextStyle phoneTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 2.43*h,
      color: const Color(0xFF242424),
      letterSpacing: 1.0,
     // height: 22.0
  );

  static final TextStyle headerTextStyle = TextStyle(
        fontFamily: 'Poppins',
        fontSize:2.43*h,
        color: Color(0xFF32338C),
        decoration: TextDecoration.none
    );
  static final TextStyle subHeaderTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 2.07*h,
      color: Color(0xFF32338C),
      decoration: TextDecoration.none
  );
  static final TextStyle header1TextStyle = TextStyle(
    fontFamily: 'Roboto Bold',
    fontSize: 1.70*h,
    color: Color(0xFF4F4F4F),
  );


  static final TextStyle appBarStyle =  TextStyle(
      fontFamily: 'Poppins',
      fontSize: 1.70*h,
      letterSpacing: 0.15,
      color: const Color(0xFF1B1C77),
      decoration: TextDecoration.none
  );

  static final TextStyle normalTextStyle = TextStyle(
      fontSize:  1.46*h,
      color: Colors.black,
      decoration: TextDecoration.none
  );
  static final TextStyle descTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize:  1.46*h,
      color: Color(0xFF686868),
      decoration: TextDecoration.none
  );
  static final TextStyle desc1TextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 1.95*h,
      color: Color(0xFF4F4F4F),
      decoration: TextDecoration.none
  );
  static final TextStyle desc2TextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize:  1.70*h,
      color: Color(0xFF828282)
  );
  static final TextStyle hintTextStyle =  TextStyle(
      fontFamily: 'Roboto',
      fontSize: 1.21*h,
      color: darkPinkColor,
      decoration: TextDecoration.none
  );

  static final TextStyle suffixTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize:  1.46*h,
  color: Color(0xFF7371FC)
  );

  static final TextStyle dropdownTextStyle = TextStyle(
    fontFamily: 'Roboto Bold',
    fontSize: 1.46*h,
    color: Color(0xFF262222),
  );

  static final TextStyle checkBoxTextStyle =  TextStyle(
      fontFamily: 'Roboto',
      fontSize: 1.46*h,
      color: Color(0xFF1B1C77)
  );


  static final TextStyle input1TextStyle =  TextStyle(
  fontFamily: 'Roboto Bold',
  fontSize: 3.41*h,
  color: Color(0xFF4F4F4F)
  );

  static final TextStyle input2TextStyle = TextStyle(
      fontFamily: 'Roboto Bold',
      fontSize: 1.95*h,
      color: Color(0xFF262222)
  );

  static final InputDecoration otpInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(
          vertical: 15.0
      ),
      enabledBorder:outlineInputBorder(),
      border: InputBorder.none,
      focusedBorder:outlineInputBorder()
  );
}

 OutlineInputBorder outlineInputBorder(){
 return OutlineInputBorder(
   borderRadius: BorderRadius.circular(5.0),
   borderSide: BorderSide(color:Style.placeHolderColor),
 ) ;
}