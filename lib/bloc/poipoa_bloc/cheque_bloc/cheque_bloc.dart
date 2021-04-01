import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cheque_events.dart';
import 'cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent,ChequeState>{

  ChequeBloc() : super(ChequeInitialState());
  APIService apiService = APIService();
  String phNo;
  SharedPrefs sharedPrefs = SharedPrefs();


  @override
  Stream<ChequeState> mapEventToState(ChequeEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(event is AddChequeEvent){
      try {
        yield ChequeLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'cancelled_cheque',ph:sharedPrefs.getPhone);
        yield ChequeSuccessState();
        prefs.setInt('cancelledCheque', 1);
      }catch(e){
        yield ChequeFailureState();
      }
    }


    if(event is CheckChequeEvent){

      if(prefs.getInt("cancelledCheque") != null && prefs.getInt("cancelledCheque")==1){
        yield ChequeSuccessState();
      }

    }




  }

}