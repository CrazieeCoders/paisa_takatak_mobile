import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loaform_event.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loanform_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanFormBloc extends Bloc<LoanFormEvent,LoanFormState>{

  LoanFormBloc() : super(LoanFromInitialState());
  APIService apiService = APIService();
  SharedPrefs _sharedPrefs = SharedPrefs();

  @override
  Stream<LoanFormState> mapEventToState(LoanFormEvent event) async*{


    // TODO: implement mapEventToState
    if(event is AddLoanFormEvent){

      try {
        yield LoanFormLoadingState();
        await apiService.registerLoanForm(event.registerationInfo);
        _sharedPrefs.setLoanApplicationForm(1);
        yield LoanFormSuccessState();
      }catch(e){
        yield LoanFormFailureState();
      }
    }
  }

}