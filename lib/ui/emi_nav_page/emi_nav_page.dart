import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Themes/Style.dart';
import 'package:paisa_takatak_mobile/Themes/size_config.dart';
import 'package:paisa_takatak_mobile/bloc/emi_nav_bloc/emi_nav_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/emi_nav_bloc/emi_nav_state.dart';
import 'package:paisa_takatak_mobile/bloc/emiBloc/drawerBloc/drawerBloc.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/bloc/emiBloc/drawerBloc/drawer_state.dart';
import 'package:paisa_takatak_mobile/bloc/emiBloc/drawerBloc/drawer_event.dart';
import 'package:paisa_takatak_mobile/Widgets/invite_friend.dart';
import 'package:paisa_takatak_mobile/Widgets/notifications.dart';


import 'emi_page.dart';



class EmiNavPageProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<EmiNavDrawerBloc>(
        create: (context) => EmiNavDrawerBloc(),
        ),
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
        ],
        child: EmiNavPage());
  }
}


double h = SizeConfig.heightMultiplier;
double w = SizeConfig.widthMultiplier;

class EmiNavPage extends StatefulWidget {
  @override
  _EmiNavPageState createState() => _EmiNavPageState();
}

class _EmiNavPageState extends State<EmiNavPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerBloc,DrawerState>(
      listener: (context,state){
        if(state is InviteFriendState){
          InviteFriend.show(context);
        }else if(state is NotificationState){
          UserNotification.show(context);
        }else if (state is AccountState){
          Navigator.pushNamed(context, '/accountPage');
        }
      },
      child: BlocBuilder<EmiNavDrawerBloc, EmiNavDrawerState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Welcome!${sharedPrefs.getUserName}', style: Style.appBarStyle),
              backgroundColor: Style.paleYellow,
              elevation: 0.0,
              centerTitle: true,
              leading: GestureDetector(
                  onTap: (){
                  _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                      height: 5.31 * h,
                      width: 7.03 * w,
                      child: Image.asset('cutouts/home/burger-menu@1.5x.png'))),
              actions: [
                SizedBox(
                  width: 6.94*w,
                ),
                GestureDetector(
                  onTap: (){
                    BlocProvider.of<DrawerBloc>(context).add(NotificationEvent());
                  },
                    child: Container(
                        height: 7.31 * h,
                        width: 8.03 * w,
                        child:
                        Image.asset('cutouts/home/notification-icon@2x.png'))),
                GestureDetector(
                    child: Container(
                        height: 7.31 * h,
                        width: 10.03 * w,
                        child: Image.asset('cutouts/home/help-icon@2x.png')))
              ],
            ),
            backgroundColor: Colors.white,
            drawer: EmiNavDrawerWidget(),
            body: EmiPage(),
          );
        },
      ),
    );
  }
}

class EmiNavDrawerWidget extends StatelessWidget {
  final List<_NavigationItem> _listItem = [
    _NavigationItem('header', null, null, null),
    _NavigationItem(
      'itemList',
      NavItem.page_one,
      "My Profile",
      Container(
          height: 7.31 * h,
          width: 8.03 * w,
          child: Image.asset('cutouts/drawer/my-profile-icon@2x.png')),
    ),
    _NavigationItem(
        'itemList',
        NavItem.page_two,
        "Offers",
        Container(
            height: 7.31 * h,
            width: 8.03 * w,
            child: Image.asset('cutouts/drawer/offers-icon@2x.png'))),
    _NavigationItem(
        'itemList',
        NavItem.page_three,
        "Notifications",
        Container(
            height: 7.31 * h,
            width: 8.03 * w,
            child: Image.asset('cutouts/drawer/notification-icon@2x.png'))),
    _NavigationItem(
        'itemList',
        NavItem.page_four,
        "Help",
        Container(
            height: 7.31 * h,
            width: 8.03 * w,
            child: Image.asset('cutouts/drawer/help-icon@2x.png'))),
    _NavigationItem('divider', null, null, null),
    _NavigationItem(
        'itemList',
        NavItem.page_five,
        "Invite a Friend",
        Container(
            height: 7.31 * h,
            width: 8.03 * w,
            child: Image.asset('cutouts/drawer/invite-friend-icon@2x.png'))),
    _NavigationItem('divider', null, null, null),
    _NavigationItem(
        'itemList',
        NavItem.page_six,
        "Logout",
        Container(
            height: 7.31 * h,
            width: 8.03 * w,
            child: Image.asset('cutouts/drawer/logout-icon@2x.png'))),
    _NavigationItem('sizedBox', null, null, null),
    _NavigationItem('bottom', null, null, null),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: _listItem.length,
            itemBuilder: (BuildContext context, int index) {
              return BlocBuilder<EmiNavDrawerBloc, EmiNavDrawerState>(
                builder: (context, state) {
                  return _buildItem(_listItem[index], state);
                },
              );
            }),
      ),
    );
  }
}

Widget _buildItem(_NavigationItem data, EmiNavDrawerState state) {
  if (data.header == "header") {
    return _makeHeaderItem();
  } else if (data.header == "itemList") {
    return _makeItemList(data, state);
  } else if (data.header == 'divider') {
    return Divider();
  } else if (data.header == 'sizedBox') {
    return SizedBox(
      height: 12.64*h,
    );
  } else if (data.header == 'bottom') {
    return Container(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.22*w,1.12*h,2.22*w,1.12*h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Toll Free  ',
                    style: Style.desc2TextStyle,
                    children: <TextSpan>[
                      TextSpan(
                        text: '8000 1245 1245',
                        style: Style.input2TextStyle,
                      ),
                    ]),
              ),
              SizedBox(
                height: 0.70*h,
              ),
              Text(
                'CustomerCare@paisatakatak.com',
                style: Style.desc2TextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // return  data.header ? _makeHeaderItem():_makeItemList(data,state);
}

Widget _makeItemList(_NavigationItem data, EmiNavDrawerState state) => Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      borderOnForeground: true,
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      child: Builder(
        builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: Style.desc2TextStyle
            ),
            leading: data.container,
        onTap: ()=>_handleItemClick(context,data.item),

        ),
      ),
    );

    void _handleItemClick(BuildContext context,NavItem item){

     switch(item){

       case NavItem.page_one:
         BlocProvider.of<DrawerBloc>(context).add(AccountEvent());
         break;
       case NavItem.page_two:
         break;
       case NavItem.page_three:
         BlocProvider.of<DrawerBloc>(context).add(NotificationEvent());
         break;
         break;
       case NavItem.page_four:
         break;
       case NavItem.page_five:
         BlocProvider.of<DrawerBloc>(context).add(InviteFriendEvent());
         break;
       case NavItem.page_six:
         break;
     }


    }


Widget _makeHeaderItem() {
  SharedPrefs prefs = SharedPrefs();
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(color: Colors.white),
    currentAccountPicture: Container(
        height: 5.31 * h,
        width: 8.03 * w,
        child: Image.asset('cutouts/drawer/profile-icon@1.5x.png')),
    accountName: Text(
      prefs.getUserName,
      style: Style.input2TextStyle,
    ),
    accountEmail: Text(
      prefs.getPhone,
      style: Style.dropdownTextStyle,
    ),
  );
}

class _NavigationItem {
  final String header;
  final NavItem item;
  final String title;
  final Widget container;

  _NavigationItem(this.header, this.item, this.title, this.container);
}
