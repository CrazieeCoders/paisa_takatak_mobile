import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';

class POIPage extends StatefulWidget {
  @override
  _POIPageState createState() => _POIPageState();
}

class _POIPageState extends State<POIPage> {
  @override
  Widget build(BuildContext context) {


    Widget dropDownButton(){
      List itemList = [
        'Aadhaar Card','Pan Card','Driving License','Voter Id',
      ];
      String valueChoose = itemList[0];
      return DropdownButton(
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 28.0,
        isExpanded: true,
        underline: SizedBox(),
        value: valueChoose,
        onChanged: (newValue){
          print('New Value :$newValue');
          setState(() {
            valueChoose = newValue;
          });
        },
        items: itemList.map((valueItem){
          return DropdownMenuItem(
              value: valueItem,
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(valueItem,
                  style: Style.dropdownTextStyle,),
              ));
        }).toList(),


      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Proof of Identification/ Address', style: Style.appBarStyle),
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
          padding: const EdgeInsets.fromLTRB(16.0,0.0, 16.0, 24.0),
          child: Container(
            width: 400,
            height: 690,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                UpperHalf(),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:40.0),
                  child: Text('Choose PDA Document',
                  style: Style.desc2TextStyle),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:40.0,right: 25.0),
                  child: Container(
                      height:40,
                      width: 150,
                      decoration: BoxDecoration(
                        color:Colors.white,
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
                  height: 30.0,
                ),
               LowerHalf(),



        ]
      ),
    ),),)
    );
  }


  Widget UpperHalf(){
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
            Container(
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
                    padding: const EdgeInsets.only(left:110.0,right:8.0,top: 8.0),
                    child: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(child: Image.asset('cutouts/POIPOA/camera-icon@1x.png'))
                ],
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Container(
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
                    padding: const EdgeInsets.only(left:110.0,right:8.0,top: 8.0),
                    child: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(child: Image.asset('cutouts/POIPOA/camera-icon@1x.png'))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Container(
            height: 30,
            width: 320,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Style.palePinkColor),
            child: Center(
              child: Text(
                'Issue Clicking?Click to see guideleines & Try again!',
                style: Style.hintTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget LowerHalf(){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40.0,
            ),
            Container(
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
                    padding: const EdgeInsets.only(left:110.0,right:8.0,top: 8.0),
                    child: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(child: Image.asset('cutouts/POIPOA/camera-icon@1x.png'))
                ],
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Container(
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
                    padding: const EdgeInsets.only(left:110.0,right:8.0,top: 8.0),
                    child: Image.asset('cutouts/POIPOA/help-icon@1x.png'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(child: Image.asset('cutouts/POIPOA/camera-icon@1x.png'))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0, bottom: 18.0),
          child: Text('Cancelled Cheque',
              style: Style.normalTextStyle),
        ),
        Center(
          child: Container(
            height: 100,
            width: 320,
            decoration: BoxDecoration(
              border: Border.all(
                color: Style.placeHolderColor,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context,'/loanAgreement', (route) => false);

            },
            child: Container(
              height: 50.0,
              width: 296.0,
              decoration: BoxDecoration(
                  color: Style.inkBlueColor,
                  borderRadius: BorderRadius.circular(5.0)
              ),
              child: Center(child: Text('Done',
                style: Style.button2TextStyle,
              ),

              ),
            ),
          ),
        ),

      ],
    );
  }



}
