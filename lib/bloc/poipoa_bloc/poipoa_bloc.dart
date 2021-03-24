import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/poipoa_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/poipoa_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';


class PoiPoaBloc extends Bloc<POIPOAEvent,POIPOAState>{

  PoiPoaBloc() : super(PoiInitialstate());
  APIService apiService = APIService();


  @override
  Stream<POIPOAState> mapEventToState(POIPOAEvent event) async*{
    // TODO: implement mapEventToState

    if(event is SelfieEvent){

      print("Came insdei Selfie event");

      try {
        yield SelfieLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'My Photo',ph: '9790348843');

        yield SelfieSuccessState();
      }catch(e){
        print("Came insdei Falilure state ${e.toString()}");
        yield SelfieFailureState();
      }
    }



  }



}