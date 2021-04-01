import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';


class LoanConfirmation extends StatefulWidget {
  @override
  _LoanConfirmationState createState() => _LoanConfirmationState();
}

class _LoanConfirmationState extends State<LoanConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: 60.0,
                  ),
                  Center(
                    child: Text('Congratulations !!',
                      style: Style.headerTextStyle,),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Container(
                        height: 100.0,
                        width: 282.0,
                        child: Image.asset('cutouts/LoanApplyConfirmation/confirm-icon@2x.png')),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text('Your Loan Application of ',
                      style: Style.subHeaderTextStyle,),
                  ),
                  Center(
                    child: Text('\u20A8 30,000 is under Process',
                    style: Style.subHeaderTextStyle,),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  Center(child: Text('We\' ll notify about your loan approval',
                  style: Style.descTextStyle,)),
                  Center(child: Text('within 3 working days',
                  style: Style.descTextStyle,)),

                 SizedBox(height: 240.0,),
                 Center(
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       Container(
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
                           child: Text('Loan Status',
                             style: Style.button1TextStyle,),
                         ),
                       ),
                       SizedBox(
                         width: 30.0,
                       ),
                       Container(
                         height: 50.0,
                         width: 156,
                         decoration: BoxDecoration(
                           color: Style.inkBlueColor,
                           borderRadius: BorderRadius.circular(5.0),
                         ),
                         child: Center(
                           child: Text('Apply Loan',
                               style:Style.button2TextStyle
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
        ],
      ),
    );
  }
}
