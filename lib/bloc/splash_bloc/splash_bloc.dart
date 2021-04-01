import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_event.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState>{

  SplashBloc() : super(SplashInitialState());

  int flag1=0;
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async*{
    // TODO: implement mapEventToState

    SharedPreferences prefs = await SharedPreferences.getInstance();

     if(event is AuthEvent){

       if(prefs.getInt("IsSignedIn") != null && prefs.getInt("IsSignedIn")==1){
          yield SplashLoadingState();

          if(prefs.getInt("loanStatus") != null && prefs.getInt("loanStatus")==1){
            yield LoanAgrementState();
          }else {


              yield SplashLoadingState();
              yield SignedInState();

          }
       }else{
         yield NotSignedInState();
       }



     }
  }

}