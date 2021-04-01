import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_events.dart';
import 'package:paisa_takatak_mobile/bloc/signUp_bloc/signUp_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpBloc extends Bloc<OtpEvent,OtpState>{

  APIService apiService = APIService();
  static String verifyOtp= '';
  bool isVerified=false;

  SignUpBloc() : super(OtpInitialState());

  @override
  Stream<OtpState> mapEventToState(OtpEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: implement mapEventToState
    try {
    if(event is SendOtpEvent){

        yield OtpLoadingState();
       verifyOtp = await apiService.generateOtp(event.phNo);
        yield SendOtpState(sendOtp:event.phNo);

    }else if(event is VerifyOtpEvent){

      isVerified = checkOtp(verifyOtp:verifyOtp,otp:event.pin);

       if(isVerified){
         prefs.setInt("IsSignedIn",1);
         prefs.setString("phNo", event.phNo);
         yield OtpSuccessState();
       }else{
         yield OtpFailureState();
      }

    }else if(event is ResendOtpEvent){

      yield OtpLoadingState();
      verifyOtp = await apiService.generateOtp(event.phNo);
      yield ResendOtpSuccessState();
    }

    }catch(e){
      yield OtpErrorState(errMsg: e.toString());
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