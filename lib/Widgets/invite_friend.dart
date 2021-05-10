import 'package:flutter/material.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:flutter/services.dart';


class InviteFriend extends StatefulWidget {

  InviteFriend({Key key}):super(key:key);

  static void show(BuildContext context,{Key key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_)=>InviteFriend(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) =>Navigator.pop(context);

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  double h = SizeConfig.heightMultiplier;

  double w = SizeConfig.widthMultiplier;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _phTextController = TextEditingController();

  FocusNode _phTextFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phTextFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phTextFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
     child: ListView(
       children: [
         GestureDetector(
          behavior: HitTestBehavior.translucent,
           onTap: (){
             InviteFriend.hide(context);
        },
           child: SizedBox(
             height: 53.37*h,
           ),
         ),
         Align(
           alignment: Alignment.bottomCenter,
           child: Padding(
             padding: EdgeInsets.only(
                 bottom: MediaQuery.of(context).viewInsets.bottom),
             child: Card(
               child: Container(
                 height: 42.13*h,
                 width: 100*w,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(9.0),
                     topRight: Radius.circular(9.0),
                   ),
                 ),
                 padding: EdgeInsets.fromLTRB(1.46*h,2.91*w,1.46*h,2.91*w),

                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Center(
                       child: Text('Invite a Friend',
                         style: Style.headerTextStyle,),
                     ),
                     SizedBox(height: 4.21*h,),
                     Padding(
                       padding: EdgeInsets.only(left:5.55*w),
                       child: Text('Mobile Number of Your Friend',
                           style: Style.desc2TextStyle
                       ),
                     ),

                     Form(
                       key: _formKey,
                       child: Padding(
                         padding: EdgeInsets.only(left:5.55*w),
                         child: Container(
                           height: 6.89 * h,
                           width: 82.55 * w,
                           child: TextFormField(
                             controller: _phTextController,
                             focusNode: _phTextFocus,
                             keyboardType: TextInputType.phone,
                             style: Style.phoneTextStyle,
                             inputFormatters: [
                               new LengthLimitingTextInputFormatter(
                                   10),
                             ],
                             decoration: InputDecoration(

                             ),
                             onChanged: (value) {
                               if (value.length == 10) {
                                 _phTextFocus.unfocus();
                               }
                             },
                             validator: (phNo) {
                               if (phNo.length != 10) {
                                 return "Please enter valid Phone Number";
                               }
                               return null;
                             },
                           ),
                         ),
                       ),
                     ),

                     Padding(
                       padding: EdgeInsets.only(left:5.55*w,top: 1.40*h),
                       child: RichText(
                         text: TextSpan(text:'Your friend will get SMS notification to Join ',
                             style: Style.purpleHintTextStyle,
                             children: <TextSpan>[
                               TextSpan(
                                 text: 'Paisa Takatak',
                                 style: Style.purpleHintBoldTextStyle,
                               ),
                             ]
                         ),
                       ),
                     ),

                     SizedBox(
                       height: 2.80*h,
                     ),

                     Center(
                       child: Padding(
                         padding: EdgeInsets.fromLTRB(3.89*w,1.95*h,3.89*w,1.95*h,),
                         child: GestureDetector(
                           onTap: (){

                           },
                           child: Container(
                             height: 6.09*h,
                             width: 72.01*w,
                             decoration: BoxDecoration(
                                 color: Style.inkBlueColor,
                                 borderRadius: BorderRadius.circular(5.0)
                             ),
                             child: Center(child: Text('Invite',
                               style: Style.button2TextStyle,
                             ),

                             ),
                           ),
                         ),
                       ),
                     ),

                   ],
                 ),
               ),
             ),
           ),
         ),
       ],
     ),
    );
  }
}
