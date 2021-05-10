import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/emi_nav_bloc/emi_nav_event.dart';
import 'package:paisa_takatak_mobile/bloc/emi_nav_bloc/emi_nav_state.dart';

class EmiNavDrawerBloc extends Bloc<EmiNavDrawerEvent,EmiNavDrawerState>{

  EmiNavDrawerBloc() : super(EmiNavDrawerState(NavItem.page_one));

  @override
  Stream<EmiNavDrawerState> mapEventToState(EmiNavDrawerEvent event) async*{
    // TODO: implement mapEventToState

    if(event is NavigateTo){

        yield EmiNavDrawerState(event.destination);

    }

  }

}