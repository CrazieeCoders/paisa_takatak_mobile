import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';


class LoadingDialog extends StatelessWidget {

  LoadingDialog({Key key}):super(key:key);

  static void show(BuildContext context,{Key key}) => showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_)=>LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) =>Navigator.pop(context);

  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Center(
        child: Card(
          child: Container(
            height: 9.75*h,
            width: 19.46*w,
            padding: EdgeInsets.fromLTRB(1.46*h,2.91*w,1.46*h,2.91*w),
            child: CircularProgressIndicator(
              backgroundColor: Style.palePurple,
            ),
          ),
        ),
      ),
    );
  }
}
