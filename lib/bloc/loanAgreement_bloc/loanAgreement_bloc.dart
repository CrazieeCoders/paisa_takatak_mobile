import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loanAgreement_event.dart';
import 'loanAgreement_state.dart';

class AgreementBloc extends Bloc<AgreementOtpEvent,AgreementOtpState>{

  APIService apiService = APIService();
  static String verifyOtp= '';
  bool isVerified=false;
  SharedPrefs sharedPrefs = SharedPrefs();

  AgreementBloc() : super(AgreementOtpInitialState());

  @override
  Stream<AgreementOtpState> mapEventToState(AgreementOtpEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: implement mapEventToState
    try {
      if(event is AgreementSendOtpEvent){

        yield AgreementOtpLoadingState();

        verifyOtp = await apiService.loanAgreementOtp(event.phNo);
        print("${verifyOtp}");
        yield AgreementSendOtpState(sendOtp:event.phNo);

      }else if(event is AgreementVerifyOtpEvent){

        print("${verifyOtp}");
        print("${event.pin}");

        isVerified = checkOtp(verifyOtp:verifyOtp,otp:event.pin);

        if(isVerified){
          sharedPrefs.setLoanAgreementSigned(1);
          yield AgreementOtpSuccessState();
        }else{
          yield AgreementOtpFailureState();
        }

      }else if(event is AgreementResendOtpEvent){

        yield AgreementOtpLoadingState();
        verifyOtp = await apiService.loanAgreementOtp(event.phNo);
        yield AgreementResendOtpSuccessState();
      }

    }catch(e){
      print('${e.toString()}');
      yield AgreementOtpErrorState(errMsg: e.toString());
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