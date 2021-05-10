import 'package:flutter_bloc/flutter_bloc.dart';
import 'drawer_event.dart';
import 'drawer_state.dart';


class DrawerBloc extends Bloc<DrawerEvent,DrawerState>{
  DrawerBloc() : super(DrawerInitialState());

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    // TODO: implement mapEventToState

    if(event is InviteFriendEvent){
      yield InviteFriendState();
    }else if(event is NotificationEvent){
      yield NotificationState();
    }else if(event is AccountEvent){
      yield AccountState();
    }


  }

}