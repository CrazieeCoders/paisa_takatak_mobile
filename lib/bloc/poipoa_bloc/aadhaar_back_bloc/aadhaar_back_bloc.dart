import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'aadhaar_back_states.dart';
import 'aadhar_back_events.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';


class AadhaarBackBloc extends Bloc<AadhaarBackEvent,AadhaarBackState>{


  AadhaarBackBloc() : super(AadhaarBackInitialState());
  APIService apiService = APIService();
  String phNo;
  SharedPrefs sharedPrefs = SharedPrefs();


  @override
  Stream<AadhaarBackState> mapEventToState(AadhaarBackEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(event is AddAadhaarBackEvent){

      try {
        yield AadhaarBackLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'aadhar_card_back',ph: sharedPrefs.getPhone);
        yield AadhaarBackSuccessState();
        prefs.setInt('aadharBack', 1);
      }catch(e){
        yield AadhaarBackFailureState();
      }
    }


    if(event is CheckAadhaarBackEvent){

      if(prefs.getInt("aadharBack") != null && prefs.getInt("aadharBack")==1){
        yield AadhaarBackSuccessState();
      }

    }



  }

}