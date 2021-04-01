import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loaform_event.dart';
import 'package:paisa_takatak_mobile/bloc/loanform_bloc/loanform_state.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';

class LoanFormBloc extends Bloc<LoanFormEvent,LoanFormState>{

  LoanFormBloc() : super(LoanFromInitialState());
  APIService apiService = APIService();

  @override
  Stream<LoanFormState> mapEventToState(LoanFormEvent event) async*{
    // TODO: implement mapEventToState
    if(event is AddLoanFormEvent){

      try {
        yield LoanFormLoadingState();
        await apiService.registerLoanForm(event.registerationInfo);
        yield LoanFormSuccessState();
      }catch(e){
        yield LoanFormFailureState();
      }
    }
  }

}