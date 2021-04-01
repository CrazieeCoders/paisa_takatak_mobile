import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'aadhaar_front_states.dart';
import 'aadhar_front_events.dart';

class AadhaarFrontBloc extends Bloc<AadhaarFrontEvent,AadhaarFrontState>{


  AadhaarFrontBloc() : super(AadhaarFrontInitialState());
  APIService apiService = APIService();
  SharedPrefs sharedPrefs = SharedPrefs();


  @override
  Stream<AadhaarFrontState> mapEventToState(AadhaarFrontEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(event is AddAadhaarFrontEvent){

      try {
        yield AadhaarFrontLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'aadhar_card_front',ph:sharedPrefs.getPhone);
        yield AadhaarFrontSuccessState();
        prefs.setInt('aadharFront', 1);
      }catch(e){
        yield AadhaarFrontFailureState();
      }
    }


    if(event is CheckAadhaarFrontEvent){

      if(prefs.getInt("aadharFront") != null && prefs.getInt("aadharFront")==1){
        yield AadhaarFrontSuccessState();
      }

    }

  }

}