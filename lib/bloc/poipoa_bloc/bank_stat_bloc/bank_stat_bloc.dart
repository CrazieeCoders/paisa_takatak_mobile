import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bank_stat_event.dart';
import 'bank_stat_state.dart';



class BankStatBloc extends Bloc<BankStatEvent,BankStatState>{

  BankStatBloc() : super(BankStatInitialState());
  APIService apiService = APIService();
  String phNo;
  SharedPrefs sharedPrefs = SharedPrefs();


  @override
  Stream<BankStatState> mapEventToState(BankStatEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(event is AddBankStatEvent){
      try {
        yield BankStatLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'bank_statement',ph:sharedPrefs.getPhone);
        yield BankStatSuccessState();
        prefs.setInt('bankStatement', 1);
      }catch(e){
        yield BankStatFailureState();
      }
    }


    if(event is CheckBankStatEvent){

      if(prefs.getInt("bankStatement") != null && prefs.getInt("bankStatement")==1){
        yield BankStatSuccessState();
      }

    }




  }

}