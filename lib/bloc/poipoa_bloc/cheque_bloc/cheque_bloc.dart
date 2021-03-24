import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';

import 'cheque_events.dart';
import 'cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent,ChequeState>{


  ChequeBloc() : super(ChequeInitialState());
  APIService apiService = APIService();



  @override
  Stream<ChequeState> mapEventToState(ChequeEvent event) async*{

    if(event is AddChequeEvent){

      print("Came Check event");

      try {
        yield ChequeLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'Cancelled Cheque',ph: '9790348843');

        yield ChequeSuccessState();
      }catch(e){
        print("Came insdei Falilure state ${e.toString()}");
        yield ChequeFailureState();
      }
    }



  }

}