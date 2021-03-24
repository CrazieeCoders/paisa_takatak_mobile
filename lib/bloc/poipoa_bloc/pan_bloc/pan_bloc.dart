import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';

class PanBloc extends Bloc<PanEvent,PanState>{


  PanBloc() : super(PanInitialState());
  APIService apiService = APIService();



  @override
  Stream<PanState> mapEventToState(PanEvent event) async*{

    if(event is AddPanEvent){

      print("Came  Pan event");

      try {
        yield PanLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'Pan Card',ph: '9790348843');

        yield PanSuccessState();
      }catch(e){
        print("Came insdei Falilure state ${e.toString()}");
        yield PanFailureState();
      }
    }



  }

}