import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_events.dart';
import 'package:paisa_takatak_mobile/bloc/poipoa_bloc/pan_bloc/pan_states.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';

import 'aadhaar_front_states.dart';
import 'aadhar_front_events.dart';

class AadhaarFrontBloc extends Bloc<AadhaarFrontEvent,AadhaarFrontState>{


  AadhaarFrontBloc() : super(AadhaarFrontInitialState());
  APIService apiService = APIService();



  @override
  Stream<AadhaarFrontState> mapEventToState(AadhaarFrontEvent event) async*{

    if(event is AddAadhaarFrontEvent){

      print("Came  Pan event");

      try {
        yield AadhaarFrontLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'Aadhaar front',ph: '9790348843');

        yield AadhaarFrontSuccessState();
      }catch(e){
        print("Came insdei Falilure state ${e.toString()}");
        yield AadhaarFrontFailureState();
      }
    }



  }

}