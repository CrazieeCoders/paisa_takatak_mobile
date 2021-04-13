import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/emi_bloc/emi_event.dart';
import 'package:paisa_takatak_mobile/bloc/emi_bloc/emi_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmiBloc extends Bloc<EmiEvent,EmiState>{

  EmiBloc() : super(EmiInitialState());
  APIService apiService= APIService();
  SharedPrefs prefs =SharedPrefs();

  @override
  Stream<EmiState> mapEventToState(EmiEvent event) async*{

    if(event is SelectEmiEvent){

      switch(event.emi){

        case '0':
          yield ZeroEmiState();
          break;
        case '1':
          yield OneEmiState();
          break;
        case '2':
          yield TwoEmiState();
          break;
        case '3':
          yield ThreeEmiState();
          break;
          default:
          yield ZeroEmiState();
          break;

      }

    }else if(event is SubmitEmiEvent){
      try {
        yield EmiLoadingState();
        await apiService.householdForm(event.houseHold);
        prefs.setHouseholdStatus(1);
        yield EmiSuccessState();
      }catch(e){
        print("Came inside Failure State");
        yield EmiFailureState();
      }

    }
  }

}
