import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/aadhaar_back_bloc/aadhaar_back_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/aadhaar_back_bloc/aadhaar_back_states.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/aadhaar_back_bloc/aadhar_back_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/aadhaar_front_bloc/aadhaar_front_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/aadhaar_front_bloc/aadhaar_front_states.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/aadhaar_front_bloc/aadhar_front_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/cheque_bloc/cheque_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/cheque_bloc/cheque_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/cheque_bloc/cheque_state.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/selfie_bloc/selfie_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/selfie_bloc/selfie_event.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/selfie_bloc/selfie_states.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/model/arguments.dart';
import 'dart:io';
import 'package:progress_indicators/progress_indicators.dart';

class POIPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SelfieBloc>(
        create: (context) => SelfieBloc()..add(CheckSelfieEvent()),
      ),
      BlocProvider<PanBloc>(
        create: (context) => PanBloc()..add(CheckPanEvent()),
      ),
      BlocProvider<ChequeBloc>(
        create: (context) => ChequeBloc()..add(CheckChequeEvent()),
      ),
      BlocProvider<AadhaarFrontBloc>(
        create: (context) => AadhaarFrontBloc()..add(CheckAadhaarFrontEvent()),
      ),
      BlocProvider<AadhaarBackBloc>(
        create: (context) => AadhaarBackBloc()..add(CheckAadhaarBackEvent()),
      ),
    ], child: POIPage());
  }
}

class POIPage extends StatefulWidget {
  Arguments args;
  SharedPrefs sharedPrefs = SharedPrefs();

  POIPage({this.args});

  @override
  _POIPageState createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {
  SelfieBloc _selfieBloc;
  PanBloc _panBloc;
  ChequeBloc _chequeBloc;
  AadhaarFrontBloc _aadhaarFrontBloc;
  AadhaarBackBloc _aadhaarBackBloc;
  static File imageFile;

  @override
  Widget build(BuildContext context) {
    _selfieBloc = BlocProvider.of<SelfieBloc>(context);
    _panBloc = BlocProvider.of<PanBloc>(context);
    _chequeBloc = BlocProvider.of<ChequeBloc>(context);
    _aadhaarFrontBloc = BlocProvider.of<AadhaarFrontBloc>(context);
    _aadhaarBackBloc = BlocProvider.of<AadhaarBackBloc>(context);

    Widget dropDownButton() {
      List itemList = [
        'Aadhaar Card',
      ];
      String valueChoose = itemList[0];

      return DropdownButton(
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 28.0,
        isExpanded: true,
        underline: SizedBox(),
        value: valueChoose,
        onChanged: (newValue) {},
        items: itemList.map((valueItem) {
          return DropdownMenuItem(
              value: valueItem,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  valueItem,
                  style: Style.dropdownTextStyle,
                ),
              ));
        }).toList(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Proof of Identification/ Address',
              style: Style.appBarStyle),
          backgroundColor: Style.paleYellow,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Style.paleYellow,
                Style.palePurple,
              ])),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: ListView(children: [
                SizedBox(
                  height: 20.0,
                ),
                UpperHalf(),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child:
                      Text('Choose PDA Document', style: Style.desc2TextStyle),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                  child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Center(child: dropDownButton())),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                      'Take front and back picture of your Aadhaar card / ',
                      style: Style.desc2TextStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text('Upload from your mobile device ',
                      style: Style.desc2TextStyle),
                ),
                SizedBox(
                  height: 30.0,
                ),
                LowerHalf(widget.args, widget.sharedPrefs),
              ]),
            ),
          ),
        ));
  }

  Widget UpperHalf() {
    return Column(
      children: [
        Center(
          child: Text(
            'Upload Documents',
            style: Style.headerTextStyle,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            SizedBox(
              width: 40.0,
            ),
            Text('Selfie/Photo', style: Style.normalTextStyle),
            SizedBox(
              width: 110.0,
            ),
            Text(
              'PAN Card',
              style: Style.normalTextStyle,
            )
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            SizedBox(
              width: 40.0,
            ),
            BlocListener<SelfieBloc, SelfieState>(
              listener: (context, state) {
                if (state is SelfieFailureState) {
                  Fluttertoast.showToast(msg: "Unable to upload the document ");
                }
              },
              child: BlocBuilder<SelfieBloc, SelfieState>(
                builder: (context, state) {
                  if (state is SelfieLoadingState) {
                    return Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 37,
                          ),
                          Center(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 28.0,
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is SelfieSuccessState) {
                    return Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                              child: Image.asset(
                                  'cutouts/POIPOA/confirm-icon@1.5x.png'))
                        ],
                      ),
                    );
                  } else if (state is SelfieFailureState) {
                    return GestureDetector(
                      onTap: () async {
                        await _showChoiceDiaLog(context);
                        _selfieBloc.add(AddSelfieEvent(img: imageFile));
                      },
                      child: Container(
                        height: 120,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Style.onclickBorderColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 110.0, right: 8.0, top: 8.0),
                              child: Image.asset(
                                'cutouts/POIPOA/help-icon-red@1x.png',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                                child: Image.asset(
                              'cutouts/POIPOA/camera-icon@1x.png',
                            ))
                          ],
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      await _showChoiceDiaLog(context);
                      _selfieBloc.add(AddSelfieEvent(img: imageFile));
                    },
                    child: Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 110.0, right: 8.0, top: 8.0),
                            child:
                                Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Image.asset(
                                  'cutouts/POIPOA/camera-icon@1x.png'))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            BlocListener<PanBloc, PanState>(
              listener: (context, state) {
                if (state is PanFailureState) {
                  Fluttertoast.showToast(msg: "Unable to upload the document ");
                }
              },
              child: BlocBuilder<PanBloc, PanState>(
                builder: (context, state) {
                  if (state is PanLoadingState) {
                    return Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 37,
                          ),
                          Center(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 28.0,
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is PanSuccessState) {
                    return Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                              child: Image.asset(
                                  'cutouts/POIPOA/confirm-icon@1.5x.png'))
                        ],
                      ),
                    );
                  } else if (state is PanFailureState) {
                    return GestureDetector(
                      onTap: () async {
                        try {
                          await _showChoiceDiaLog(context);
                          _panBloc.add(AddPanEvent(img: imageFile));
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "Please select a document");
                        }
                      },
                      child: Container(
                        height: 120,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Style.onclickBorderColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 110.0, right: 8.0, top: 8.0),
                              child: Image.asset(
                                'cutouts/POIPOA/help-icon-red@1x.png',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                                child: Image.asset(
                              'cutouts/POIPOA/camera-icon@1x.png',
                            ))
                          ],
                        ),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () async {
                      await _showChoiceDiaLog(context);
                      _panBloc.add(AddPanEvent(img: imageFile));
                    },
                    child: Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 110.0, right: 8.0, top: 8.0),
                            child:
                                Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Image.asset(
                                  'cutouts/POIPOA/camera-icon@1x.png'))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    );
  }

  Widget LowerHalf(Arguments args, SharedPrefs sharedPrefs) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 40.0,
            ),
            BlocListener<AadhaarFrontBloc, AadhaarFrontState>(
              listener: (context, state) {
                if (state is AadhaarFrontFailureState) {
                  Fluttertoast.showToast(msg: "Unable to upload the document ");
                }
              },
              child: BlocBuilder<AadhaarFrontBloc, AadhaarFrontState>(
                builder: (context, state) {
                  if (state is AadhaarFrontLoadingState) {
                    return Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 37,
                          ),
                          Center(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 28.0,
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state is AadhaarFrontSuccessState) {
                    return Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                              child: Image.asset(
                                  'cutouts/POIPOA/confirm-icon@1.5x.png'))
                        ],
                      ),
                    );
                  } else if (state is AadhaarFrontFailureState) {
                    return GestureDetector(
                      onTap: () async {
                        await _showChoiceDiaLog(context);
                        _aadhaarFrontBloc
                            .add(AddAadhaarFrontEvent(img: imageFile));
                      },
                      child: Container(
                        height: 120,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Style.onclickBorderColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 110.0, right: 8.0, top: 8.0),
                              child: Image.asset(
                                'cutouts/POIPOA/help-icon-red@1x.png',
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                                child: Image.asset(
                              'cutouts/POIPOA/camera-icon@1x.png',
                            ))
                          ],
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      await _showChoiceDiaLog(context);
                      _aadhaarFrontBloc
                          .add(AddAadhaarFrontEvent(img: imageFile));
                    },
                    child: Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.placeHolderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 110.0, right: 8.0, top: 8.0),
                            child:
                                Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Column(
                            children: [
                              Image.asset('cutouts/POIPOA/camera-icon@1x.png'),
                              Text(
                                'Front',
                                style: Style.desc2TextStyle,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            BlocListener<AadhaarBackBloc, AadhaarBackState>(
              listener: (context, state) {
                if (state is AadhaarBackFailureState) {
                  Fluttertoast.showToast(msg: "Unable to upload the document ");
                }
              },
              child: BlocBuilder<AadhaarBackBloc, AadhaarBackState>(
                  builder: (context, state) {
                if (state is AadhaarBackLoadingState) {
                  return Container(
                    height: 120,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Style.placeHolderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 37,
                        ),
                        Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 28.0,
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is AadhaarBackSuccessState) {
                  return Container(
                    height: 120,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Style.placeHolderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Center(
                            child: Image.asset(
                                'cutouts/POIPOA/confirm-icon@1.5x.png'))
                      ],
                    ),
                  );
                } else if (state is AadhaarBackFailureState) {
                  return GestureDetector(
                    onTap: () async {
                      await _showChoiceDiaLog(context);
                      _aadhaarBackBloc.add(AddAadhaarBackEvent(img: imageFile));
                    },
                    child: Container(
                      height: 120,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.onclickBorderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 110.0, right: 8.0, top: 8.0),
                            child: Image.asset(
                              'cutouts/POIPOA/help-icon-red@1x.png',
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Image.asset(
                            'cutouts/POIPOA/camera-icon@1x.png',
                          ))
                        ],
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () async {
                    await _showChoiceDiaLog(context);
                    _aadhaarBackBloc.add(AddAadhaarBackEvent(img: imageFile));
                  },
                  child: Container(
                    height: 120,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Style.placeHolderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 110.0, right: 8.0, top: 8.0),
                          child: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Column(
                          children: [
                            Image.asset('cutouts/POIPOA/camera-icon@1x.png'),
                            Text(
                              'Back',
                              style: Style.desc2TextStyle,
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, bottom: 18.0),
          child: Text('Cancelled Cheque', style: Style.normalTextStyle),
        ),
        BlocListener<ChequeBloc, ChequeState>(
          listener: (context, state) {
            if (state is ChequeFailureState) {
              Fluttertoast.showToast(msg: "Unable to upload the document ");
            }
          },
          child: BlocBuilder<ChequeBloc, ChequeState>(
            builder: (context, state) {
              if (state is ChequeLoadingState) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Container(
                    height: 100,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Style.placeHolderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 28.0,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is ChequeFailureState) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await _showChoiceDiaLog(context);
                        _chequeBloc.add(AddChequeEvent(img: imageFile));
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "No documents selected",
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    },
                    child: Container(
                      height: 100,
                      width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Style.onclickBorderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 260.0, right: 8.0, top: 8.0),
                            child: Image.asset(
                                'cutouts/POIPOA/help-icon-red@1x.png'),
                          ),
                          Center(
                              child: Image.asset(
                                  'cutouts/POIPOA/camera-icon@1x.png')),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is ChequeSuccessState) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Container(
                    height: 100,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Style.placeHolderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        Center(
                            child: Image.asset(
                                'cutouts/POIPOA/confirm-icon@1.5x.png'))
                      ],
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: GestureDetector(
                  onTap: () async {
                    await _showChoiceDiaLog(context);
                    _chequeBloc.add(AddChequeEvent(img: imageFile));
                  },
                  child: Container(
                    height: 100,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Style.placeHolderColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 260.0, right: 8.0, top: 8.0),
                          child: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                        ),
                        Center(
                            child:
                                Image.asset('cutouts/POIPOA/camera-icon@1x.png')),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 66.0, top: 20.0, right: 46.0, bottom: 10.0),
          child: GestureDetector(
            onTap: () {
              int selfieStatus = sharedPrefs.getSelfieStatus;
              int panStatus = sharedPrefs.getpanCardStatus;
              int adhaarFrontStatus = sharedPrefs.getAadharFrontStatus;
              int adhaarBackStatus = sharedPrefs.getAadharBackStatus;
              int chequeStatus = sharedPrefs.getChequeStatus;

              print(
                  '${selfieStatus}${panStatus}${adhaarFrontStatus}${adhaarBackStatus}${chequeStatus}');

              if (selfieStatus == 1 &&
                  panStatus == 1 &&
                  adhaarFrontStatus == 1 &&
                  adhaarBackStatus == 1 &&
                  chequeStatus == 1) {
                Navigator.pushNamed(
                  context,
                  '/loanForm',
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Please upload all the documents*",
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            },
            child: Center(
              child: Container(
                height: 50.0,
                width: 296.0,
                decoration: BoxDecoration(
                    color: Style.inkBlueColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Center(
                  child: Text(
                    'Done',
                    style: Style.button2TextStyle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showChoiceDiaLog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Make a choice',
              style: Style.dropdownTextStyle,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    onTap: () {
                      _openGallery(context);
                    },
                    child: Text(
                      'Gallery',
                      style: Style.desc1TextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openCamera(context);
                    },
                    child: Text(
                      'Camera',
                      style: Style.desc1TextStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openCamera(BuildContext context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
  }
}
