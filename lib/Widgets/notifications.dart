import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';



class UserNotification extends StatefulWidget {

  UserNotification({Key key}):super(key:key);

  static void show(BuildContext context,{Key key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_)=>UserNotification(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) =>Navigator.pop(context);

  @override
  _UserNotificationState createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: ListView(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              UserNotification.hide(context);
            },
            child: SizedBox(
              height: 53.37*h,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              child: Container(
                height: 52.13*h,
                width: 100*w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(1.46*h,2.97*w,1.46*h,2.91*w),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Notifications',
                        style: Style.headerTextStyle,),
                    ),
                    SizedBox(height: 4.21*h,),
                    Center(
                      child: Text('Mon,28/02/2021',
                          style: Style.desc2TextStyle
                      ),
                    ),
                  SizedBox(height:1.40*h),

                  Card(
                    elevation: 2.0,
                   shape: RoundedRectangleBorder(
                     side: BorderSide(color: Colors.orange.withOpacity(0.5),width: 1),
                     borderRadius: BorderRadius.circular(10),
                   ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(2.77*w,1.4*h,2.77*w,1.4*h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dear Customer, your March 2021 EMI of Rs. 1047 is due'
                                'on 05/03/21,keep your account funded to avoid '
                                'charges.',
                            style: Style.notificationTextStyle,
                            ),
                            SizedBox(height: 1.4*h,),
                            Text('6:07 PM',
                              style: Style.notificationTextStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                    SizedBox(height: 4.21*h,),
                    Center(
                      child: Text('Sat,26/02/2021',
                          style: Style.desc2TextStyle
                      ),
                    ),
                    SizedBox(height:1.4*h),

                    Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.orange.withOpacity(0.5),width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(2.77*w,1.4*h,2.77*w,1.4*h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dear Customer, your March 2021 EMI of Rs. 1047 is due'
                                  'on 05/03/21,keep your account funded to avoid '
                                  'charges.',
                                style: Style.notificationTextStyle,
                              ),
                              SizedBox(height: 1.4*h,),
                              Text('11:05 PM',
                                style: Style.notificationTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
