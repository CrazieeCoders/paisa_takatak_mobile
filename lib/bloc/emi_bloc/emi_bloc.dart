import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';
import 'file:///C:/Users/jsurulir/AndroidStudioProjects/arsey/paisa_takatak_mobile/lib/bloc/emi_bloc/emi_event.dart';
import 'file:///C:/Users/jsurulir/AndroidStudioProjects/arsey/paisa_takatak_mobile/lib/bloc/emi_bloc/emi_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';

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
      }on AppException{
        yield EmiFailureState();
      }catch(e){
        yield EmiFailureState();
      }

    }
  }

}
