import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/loan_confirmation_bloc/loan_confirmation_state.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';

import 'loan_confirmation_event.dart';

class LoanConfirmationBloc extends Bloc<LoanConfirmationEvent,LoanConfirmationState>{
  LoanConfirmationBloc() : super(InitialLoanConfirmation());

  APIService apiService = APIService();



  @override
  Stream<LoanConfirmationState> mapEventToState(LoanConfirmationEvent event) async*{

    if(event is LoanConfirmationPressed){

      try{
        yield LoanConfirmationLoading();
        await apiService.loanConfirmation();
        await apiService.getProfileDetails();
        yield LoanConfirmationSuccess();
      }catch(e){
        print(e.toString());
        yield LoanConfirmationFailure();
      }

    }

  }
}