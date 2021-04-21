import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'package:paisa_takatak_mobile/data/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paisa_takatak_mobile/Exception/custom_exception.dart';

class PanBloc extends Bloc<PanEvent,PanState>{


  PanBloc() : super(PanInitialState());
  APIService apiService = APIService();
  String phNo;
  SharedPrefs sharedPrefs = SharedPrefs();


  @override
  Stream<PanState> mapEventToState(PanEvent event) async*{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(event is AddPanEvent){
      try {
        yield PanLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'pan_card',ph:sharedPrefs.getPhone);
        yield PanSuccessState();
        prefs.setInt('panCard', 1);
      }on InvalidFileException{
        yield PanFailureState(errMsg:"Please upload a valid pan card");
      }catch(e){
        yield PanFailureState(errMsg: "Unable to upload the Document");
      }
    }


    if(event is CheckPanEvent){

      if(prefs.getInt("panCard") != null && prefs.getInt("panCard")==1){
        yield PanSuccessState();
      }

    }



  }

}