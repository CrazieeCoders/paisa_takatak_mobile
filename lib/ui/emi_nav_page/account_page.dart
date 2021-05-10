import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/Widgets/notifications.dart';

import '../loan_form.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;
  SharedPrefs sharedPrefs = SharedPrefs();

  TextEditingController nameTextController;
  TextEditingController phTextController;
  TextEditingController ph2TextController = TextEditingController();
  TextEditingController addr1TextController;
  TextEditingController pin1TextController = TextEditingController();
  TextEditingController addr2TextController = TextEditingController();
  TextEditingController pin2TextController = TextEditingController();
  TextEditingController panTextController = TextEditingController();
  TextEditingController uidTextController = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '#### #### ####', filter: {"#": RegExp(r'[0-9]')});
  final _formKey = GlobalKey<FormState>();

  bool nameEdit = false;
  bool phEdit = false;
  bool addrEdit = false;

  int flag = 0;

  @override
  Widget build(BuildContext context) {
    nameTextController =
        TextEditingController(text: '${sharedPrefs.getUserName}');
    phTextController = TextEditingController(text: '${sharedPrefs.getPhone}');
    addr1TextController =
        TextEditingController(text: '${sharedPrefs.getPermanentAddress}');
    pin1TextController =
        TextEditingController(text: '${sharedPrefs.getPinCode}');

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: Style.appBarStyle),
        backgroundColor: Style.paleYellow,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('cutouts/verify-otp/Icon-Arrow-Left@1.5x.png')),
        actions: [
          SizedBox(
            width: 6.94 * w,
          ),
          GestureDetector(
            onTap: (){
              UserNotification.show(context);
            },
              child: Container(
                  height: 7.31 * h,
                  width: 8.03 * w,
                  child: Image.asset('cutouts/home/notification-icon@2x.png'))),
          GestureDetector(
              child: Container(
                  height: 7.31 * h,
                  width: 10.03 * w,
                  child: Image.asset('cutouts/home/help-icon@2x.png')))
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
              padding: EdgeInsets.fromLTRB(w * 3.91, 0.0, w * 3.91, h * 1.95),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                              height: 22.31 * h,
                              width: 18.03 * w,
                              child: Image.asset(
                                  'cutouts/drawer/profile-icon@3x.png')),
                        ),
                        Positioned(
                          top: 10.674 * h,
                          left: 43.20 * w,
                          child: Container(
                              height: 9.31 * h,
                              width: 6.03 * w,
                              child: Image.asset(
                                  'cutouts/my-profile/my-profile-camera-icon@3x.png')),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w),
                      child: Text('Full Name of the Applicant',
                          style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Wrap(
                          children: [
                            Container(
                              height: 5.67 * h,
                              width: 87.59 * w,
                              child: Row(
                                children: [
                                  Container(
                                    height: 5.67 * h,
                                    width: 67.59 * w,
                                    child: TextFormField(
                                      enabled: nameEdit,
                                      // readOnly:  true,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: nameTextController,
                                      keyboardType: TextInputType.text,
                                      style: Style.input2TextStyle,
                                      inputFormatters: [],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            2.43 * w,
                                            1.21 * h,
                                            0.43 * w,
                                            1.21 * h),
                                        border: InputBorder.none,
                                        //  hintText: '${sharedPrefs.getUserName}',
                                        //    hintStyle: Style.input2TextStyle
                                      ),
                                      /*   validator: (value) {
                  if (value.isEmpty || value == '') {
                    return "Please enter your name";
                  }else if(value.length < 3){
                    return "Please enter a valid name";
                  }
                  return null;
                },*/
                                    ),
                                  ),
                                  Container(
                                    height: 5.67 * h,
                                    width: 15 * w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          nameEdit = true;
                                          print('$nameEdit');
                                        });
                                      },
                                      splashColor: Colors.indigo,
                                      child: Center(
                                        child: Text(
                                          'Edit ',
                                          style: Style.suffixTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Text('Primary Contact Number',
                          style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Wrap(
                          children: [
                            Container(
                              height: 5.67 * h,
                              width: 87.59 * w,
                              child: Row(
                                children: [
                                  Container(
                                    height: 5.67 * h,
                                    width: 67.59 * w,
                                    child: TextFormField(
                                      enabled: phEdit,
                                      //    readOnly: true,
                                      controller: phTextController,
                                      keyboardType: TextInputType.phone,
                                      style: Style.input2TextStyle,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            2.43 * w,
                                            1.21 * h,
                                            2.43 * w,
                                            1.21 * h),
                                        border: InputBorder.none,

                                        //    hintText: '${sharedPrefs.getPhone}',
                                        //    hintStyle: Style.input2TextStyle
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 5.67 * h,
                                    width: 15 * w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          phEdit = true;
                                        });
                                      },
                                      splashColor: Colors.indigo,
                                      child: Center(
                                        child: Text(
                                          'Edit ',
                                          style: Style.suffixTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Text('Secondary Contact Number *',
                          style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Container(
                          height: 5.67 * h,
                          width: 87.59 * w,
                          child: TextFormField(
                            controller: ph2TextController,
                            keyboardType: TextInputType.phone,
                            style: Style.input2TextStyle,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  2.43 * w, 1.21 * h, 2.43 * w, 1.21 * h),
                              border: InputBorder.none,
                              //  suffixIcon: Image.asset('cutouts/POIPOA/help-icon@1x.png')
                            ),
                            validator: (ph) {
                              if (ph == '') {
                                return "Please enter the secondary contact number";
                              } else if (ph.length != 10) {
                                return "Please enter a valid number";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Text('Permanent Address',
                          style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Wrap(
                          children: [
                            Container(
                                height: 5.67 * h,
                                width: 87.59 * w,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 5.67 * h,
                                      width: 67.59 * w,
                                      child: TextFormField(
                                        enabled: addrEdit,
                                        //  readOnly: true,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        controller: addr1TextController,
                                        keyboardType: TextInputType.text,
                                        style: Style.input2TextStyle,
                                        inputFormatters: [
                                          //  FilteringTextInputFormatter. digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              2.43 * w,
                                              1.21 * h,
                                              2.43 * w,
                                              1.21 * h),
                                          border: InputBorder.none,

                                          //   hintText: '${sharedPrefs.getPermanentAddress}',
                                          //    hintStyle: Style.input2TextStyle
                                        ),
                                        /* validator: (value) {
                  if (value.isEmpty || value == '') {
                    return "Please enter a permanent address.";
                  }else if(value.length <3){
                    return 'Please enter a valid address';
                  }
                  return null;
                },*/
                                      ),
                                    ),
                                    Container(
                                      height: 5.67 * h,
                                      width: 15 * w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            addrEdit = true;
                                          });
                                        },
                                        splashColor: Colors.indigo,
                                        child: Center(
                                          child: Text(
                                            'Edit ',
                                            style: Style.suffixTextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.86 * w,
                      ),
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.94 * w),
                              child: Text(
                                'Area pin : ',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 1.46 * h,
                                    color: Color(0xFF7371FC)),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 1.0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.94 * w),
                              child: Container(
                                height: 5.67 * h,
                                width: 68.89 * w,
                                child: TextFormField(
                                  enabled: addrEdit,
                                  //  readOnly: true,
                                  controller: pin1TextController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontFamily: 'Roboto Bold',
                                      fontSize: 1.70 * h,
                                      color: Color(0xFF7371FC)),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        1.94 * w, 0.97 * h, 1.94 * w, 0.97 * h),
                                    border: InputBorder.none,
                                    //  hintText: '${sharedPrefs.getPinCode}',
                                    //  hintStyle: Style.input2TextStyle
                                  ),
                                  /*     validator: (value) {
                        if (value.isEmpty || value == '') {
                          return "Please enter the area pin.";
                        }else if(value.length !=6){
                          return "Please enter a valid pin";
                        }
                        return null;
                      },*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Text('Local Address', style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Container(
                          height: 5.67 * h,
                          width: 87.59 * w,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: addr2TextController,
                            keyboardType: TextInputType.text,
                            style: Style.input2TextStyle,
                            inputFormatters: [
                              //  FilteringTextInputFormatter. digitsOnly
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  2.43 * w, 1.21 * h, 2.43 * w, 1.21 * h),
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      4.16 * w, 2.10 * h, 4.16 * w, 2.10 * h),
                                  child: Text(
                                    'Edit ',
                                    style: Style.suffixTextStyle,
                                  )),
                            ),
                            validator: (value) {
                              if (value.isEmpty || value == '') {
                                return "Please enter the local address";
                              } else if (value.length < 3) {
                                return 'Please enter a valid address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w),
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.97 * h),
                              child: Text(
                                'Area pin : ',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 1.46 * h,
                                    color: Color(0xFF7371FC)),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 1.0,
                            child: Container(
                              height: 5.67 * h,
                              width: 68.89 * w,
                              child: TextFormField(
                                controller: pin2TextController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: 'Roboto Bold',
                                    fontSize: 1.70 * h,
                                    color: Color(0xFF7371FC)),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      1.94 * w, 0.97 * h, 1.94 * w, 0.97 * h),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value == '') {
                                    return "Please enter the Area pin";
                                  } else if (value.length != 6) {
                                    return "Please enter a valid pin";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Text('PAN Card', style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Container(
                          height: 5.67 * h,
                          width: 87.59 * w,
                          child: TextFormField(
                            enabled: false,
                            readOnly: true,
                            controller: panTextController,
                            keyboardType: TextInputType.text,
                            style: Style.input2TextStyle,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    2.43 * w, 1.21 * h, 2.43 * w, 1.21 * h),
                                border: InputBorder.none,
                                hintText: '${sharedPrefs.getPanNumber}',
                                hintStyle: Style.input2TextStyle),
                            /*  validator: (value) {
                  if(value == ''){
                  return "Please enter your PAN Card number";
                  }else if (!RegExp(r'^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$').hasMatch(value)) {
                    return "Please enter a valid PAN card number";
                  }
                  return null;
                },*/
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Text('UID Number', style: Style.desc2TextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.86 * w, top: 1.21 * h),
                      child: Card(
                        elevation: 1.0,
                        child: Container(
                          height: 5.67 * h,
                          width: 87.59 * w,
                          child: TextFormField(
                            enabled: false,
                            readOnly: true,
                            controller: uidTextController,
                            keyboardType: TextInputType.number,
                            style: Style.input2TextStyle,
                            inputFormatters: [
                              maskFormatter,
                              LengthLimitingTextInputFormatter(14),
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    2.43 * w, 1.21 * h, 2.43 * w, 1.21 * h),
                                border: InputBorder.none,
                                hintText: '${sharedPrefs.getUidNumber}',
                                hintStyle: Style.input2TextStyle),
                            /*    validator: (value) {
                   if(value == ''){
                  return 'Please enter your UID';
                  }else if (value.length != 14) {
                    return "Please enter a valid UID";
                  }
                  return null;
                },*/
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
