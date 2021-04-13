import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Widgets/internet_connectivity.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/network_bloc/network_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';


class LoanConfirmation extends StatefulWidget {
  @override
  _LoanConfirmationState createState() => _LoanConfirmationState();
}

class _LoanConfirmationState extends State<LoanConfirmation> {

  SharedPrefs sharedPrefs = SharedPrefs();
  double h = SizeConfig.heightMultiplier;
  double w = SizeConfig.widthMultiplier;
  int flag =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NetworkBloc,NetworkState>(
        listener: (context,state){

      if(state is ConnectionFailure){
        flag = 1;
        InternetConnectivity.show(context);
      }else if(state is ConnectionSuccess){
        if(flag ==1) {
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
              padding: EdgeInsets.fromLTRB(3.89*w, 7.31*h, 3.89*w, 1.95*h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 7.31*h,
                    ),
                    Center(
                      child: Text('Congratulations !!',
                        style: Style.headerTextStyle,),
                    ),
                    SizedBox(
                      height: 2.43*h,
                    ),
                    Center(
                      child: Container(
                          height: 12.19*h,
                          width: 68.61*w,
                          child: Image.asset('cutouts/LoanApplyConfirmation/confirm-icon@2x.png')),
                    ),
                    SizedBox(
                      height: 2.43*h,
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
                      height: 3.65*h,
                    ),

                    Center(child: Text('We\' ll notify about your loan approval',
                    style: Style.descTextStyle,)),
                    Center(child: Text('within 3 working days',
                    style: Style.descTextStyle,)),

                   SizedBox(height: 29.26*h,),
                   Center(
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                       GestureDetector(
                        onTap: (){
                        },
                           child: Container(
                             height:6.09*h,
                             width: 37.95*w,
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
                         ),
                         SizedBox(
                           width: 7.29*w,
                         ),
                         GestureDetector(
                           onTap: (){
                           },
                           child: Container(
                             height: 6.09*h,
                             width:  37.95*w,
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
      ),
    );
  }


}
