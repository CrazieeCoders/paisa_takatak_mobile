import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';

class EmiPage extends StatefulWidget {
  @override
  _EmiPageState createState() => _EmiPageState();
}

class _EmiPageState extends State<EmiPage> {
  int flag = 0;
  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;

  SharedPrefs _prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!${_prefs.getUserName}', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
            child: Container(
                height: 7.31 * h,
                width: 17.03 * w,
                child: Image.asset('cutouts/home/burger-menu@1.5x.png'))),
        actions: [
          SizedBox(
            width: 45.0,
          ),
          GestureDetector(
              child: Container(
                  height: 7.31 * h,
                  width: 8.03 * w,
                  child:
                      Image.asset('cutouts/home/notification-icon@1.5x.png'))),
          GestureDetector(
              child: Container(
                  height: 7.31 * h,
                  width: 14.03 * w,
                  child: Image.asset('cutouts/home/help-icon@1.5x.png')))
        ],
      ),
      body: BlocListener<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is ConnectionFailure) {
            flag = 1;
            InternetConnectivity.show(context);
          } else if (state is ConnectionSuccess) {
            if (flag == 1) {
              InternetConnectivity.hide(context);
            }
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Style.paleYellow,
                    Style.palePurple,
                  ],
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.fromLTRB(3.89 * w, 1.46 * h, 3.89 * w, 2.92 * h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: ListView(
                    children: [
                      SizedBox(height: 20.0,),

                      Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Container(
                                  height: 7.31 * h,
                                  width: 8.03 * w,
                                  child:
                                  Image.asset('cutouts/home/confirm-icon-blue@1.5x.png')),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:3.0),
                              child: Text('xxxx xxxx 1578'),
                            ),
                            SizedBox(width: 160,),
                           Icon(Icons.arrow_drop_down_sharp),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: Text('Last Visited 12-01-2021 01:21 PM',
                              style: Style.desc2TextStyle)),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Container(
                              height: 20.63 * h,
                              width: 39.06 * w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Style.placeHolderColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    Container(
                                        height: 5.31 * h,
                                        width: 8.03 * w,
                                        child:
                                        Image.asset('cutouts/home/rupee-filled-icon@1.5x.png')),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('30,000',
                                        style: Style.input1TextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('Total OutStanding',
                                          style: Style.desc2TextStyle
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        height: 3.09 * h,
                                        width: 15.01 * w,
                                        decoration: BoxDecoration(
                                            color: Style.inkBlueColor,
                                            borderRadius: BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            'Renew',
                                            style: Style.smallButton2TextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Container(
                              height: 20.63 * h,
                              width: 39.06 * w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Style.placeHolderColor,
                                ),
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     Container(
                                        height: 5.31 * h,
                                        width: 8.03 * w,
                                        child:
                                        Image.asset('cutouts/home/rupee-outlined-icon@1.5x.png')),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('1,047',
                                        style: Style.input1TextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('Due Date 05-03-21',
                                          style: Style.desc2TextStyle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('EMI 3/36',
                                        style: Style.input2TextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Container(
                          height: 7.09 * h,
                          width: 82.01 * w,
                          decoration: BoxDecoration(
                              color: Style.inkBlueColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                            child: Text(
                              'Pay Now',
                              style: Style.button2TextStyle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Last 2 Transactions',
                              style: Style.dropdownTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text('ALL PAYMENTS',
                                style: Style.desc2TextStyle),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: 7.63 * h,
                          width: 39.06 * w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Style.placeHolderColor,
                            ),
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Container(
                                  height: 7.31 * h,
                                  width: 8.03 * w,
                                  child:
                                  Image.asset('cutouts/home/confirm-outlined-icon@1.5x.png')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text('1,047'),
                                ),
                                SizedBox(width: 100,),
                                Text('EMI Paid on 05-02-21',
                                    style: Style.desc2TextStyle
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: 7.63 * h,
                          width: 39.06 * w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Style.placeHolderColor,
                            ),
                              borderRadius: BorderRadius.circular(5.0)
                          ),

                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Container(
                                      height: 7.31 * h,
                                      width: 8.03 * w,
                                      child:
                                      Image.asset('cutouts/home/confirm-outlined-icon@1.5x.png')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text('1,047'),
                                ),
                                SizedBox(width: 100,),
                                Text('EMI Paid on 05-02-21',
                                    style: Style.desc2TextStyle
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
