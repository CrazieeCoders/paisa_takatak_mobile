import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/selfie_bloc/selfie_event.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/selfie_bloc/selfie_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SelfieBloc extends Bloc<SelfieEvent,SelfieState>{

  SelfieBloc() : super(SelfieInitialstate());
  APIService apiService = APIService();
  String phNo;
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Stream<SelfieState> mapEventToState(SelfieEvent event) async*{
    // TODO: implement mapEventToState

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(event is AddSelfieEvent){
      try {
        yield SelfieLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'selfie_photo',ph:sharedPrefs.getPhone);

        yield SelfieSuccessState();
        prefs.setInt('selfieStatus', 1);
      }catch(e){
        print('${e.toString()}');
        yield SelfieFailureState();
      }
    }

    if(event is CheckSelfieEvent){

       if(prefs.getInt("selfieStatus") != null && prefs.getInt("selfieStatus")==1){
         yield SelfieSuccessState();
       }

    }



  }



}

