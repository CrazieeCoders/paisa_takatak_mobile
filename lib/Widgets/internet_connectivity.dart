import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_event.dart';



class InternetConnectivity extends StatelessWidget {

  InternetConnectivity({Key key}):super(key: key);


  static void show(BuildContext context,{Key key})=>showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_)=>InternetConnectivity(key: key,),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));


  static void hide(BuildContext context){
     Navigator.pop(context);
   }



  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        elevation: 1.0,
        child: Container(
          height: 17.07*h,
          width: 58.39*w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('No Internet Connectivity',
                  style: Style.textStyle1,
                    ),
              ),
              Center(
                child: Text('Please try again later!!',
                  style: Style.textStyle1,
                ),
              ),
              SizedBox(
                height: 2.43*h,
              ),

              RaisedButton(
                onPressed: (){
                },
                splashColor: Colors.white,
                color: Style.inkBlueColor,
                child: Text('Retry',
                  style: Style.button2TextStyle,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
