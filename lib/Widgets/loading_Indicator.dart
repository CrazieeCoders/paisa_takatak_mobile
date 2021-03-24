import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';


class LoadingDialog extends StatelessWidget {

  LoadingDialog({Key key}):super(key:key);

  static void show(BuildContext context,{Key key}) => showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_)=>LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) =>Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Center(
        child: Card(
          child: Container(
            height: 80.0,
            width: 80.0,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(
              backgroundColor: Style.palePurple,
            ),
          ),
        ),
      ),
    );
  }
}
