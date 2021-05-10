import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paisa_takatak_mobile/bloc/renewLoanBloc/renew_loan_event.dart';
import 'package:paisa_takatak_mobile/bloc/renewLoanBloc/renewLoan_state.dart';



class RenewLoanBloc extends Bloc<RenewOtpEvent,RenewOtpState>{

  APIService apiService = APIService();
  static String verifyOtp= '';
  bool isVerified=false;
  SharedPrefs sharedPrefs = SharedPrefs();

  RenewLoanBloc() : super(RenewOtpInitialState());

  @override
  Stream<RenewOtpState> mapEventToState(RenewOtpEvent event) async*{

    // TODO: implement mapEventToState
    try {
      if(event is RenewSendOtpEvent){

        yield RenewOtpLoadingState();

        verifyOtp = await apiService.loanAgreementOtp(event.phNo);
        yield RenewSendOtpState(sendOtp:event.phNo);

      }else if(event is RenewVerifyOtpEvent){

        isVerified = checkOtp(verifyOtp:verifyOtp,otp:event.pin);

        if(isVerified){

          yield RenewOtpSuccessState();
        }else{
          yield RenewOtpFailureState();
        }

      }else if(event is RenewResendOtpEvent){

        yield RenewOtpLoadingState();
        verifyOtp = await apiService.loanAgreementOtp(event.phNo);
        yield RenewResendOtpSuccessState();
      }

    }on AppException{
      yield RenewOtpErrorState(errMsg:"Error communicating with server");
    }catch(e){
      yield RenewOtpErrorState(errMsg: e.toString());
    }
  }



  bool checkOtp({@required String verifyOtp,@required String otp}){

    if(verifyOtp == otp){
      return true;
    }else{
      return false;
    }

  }
}