import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_event.dart';
import 'package:paisa_takatak_mobile/bloc/splash_bloc/splash_state.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:paisa_takatak_mobile/model/household_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState());

  int flag1 = 0;
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    // TODO: implement mapEventToState

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is AuthEvent) {
      yield SplashLoadingState();

      if (prefs.getInt("IsSignedIn") != null &&
          prefs.getInt("IsSignedIn") == 1) {
        int selfieStatus = sharedPrefs.getSelfieStatus;
        int panCardStatus = sharedPrefs.getpanCardStatus;
        int AadharFrontStatus = sharedPrefs.getAadharFrontStatus;
        int AadharBackStatus = sharedPrefs.getAadharBackStatus;
        int ChequeStatus = sharedPrefs.getChequeStatus;

        if (selfieStatus == 1 &&
            panCardStatus == 1 &&
            AadharFrontStatus == 1 &&
            AadharBackStatus == 1 &&
            ChequeStatus == 1) {
          if (sharedPrefs.getLoanApplicationForm == 1) {
            if (sharedPrefs.getHouseHoldStatus == 1) {
              if (sharedPrefs.getLoanAgreementSigned == 1) {
                if (sharedPrefs.getLoanApplicationUnderProcess == 1) {
                  yield LoanAppProcessSuccessState();
                }else{
                  yield LoanConfirmPageState();
                }
              } else {
                yield LoanAgreementPageState();
              }
            } else {
              yield HouseHoldFormPageState();
            }
          } else {
            yield LoanFormPageState();
          }
        } else {
          yield DocumentuploadPageState();
        }
      } else {
        yield NotSignedInState();
      }
    }
  }
}
