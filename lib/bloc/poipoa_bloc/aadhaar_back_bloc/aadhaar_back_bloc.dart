import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/services/api_services.dart';
import 'aadhaar_back_states.dart';
import 'aadhar_back_events.dart';


class AadhaarBackBloc extends Bloc<AadhaarBackEvent,AadhaarBackState>{


  AadhaarBackBloc() : super(AadhaarBackInitialState());
  APIService apiService = APIService();



  @override
  Stream<AadhaarBackState> mapEventToState(AadhaarBackEvent event) async*{

    if(event is AddAadhaarBackEvent){

      print("Came  Pan event");

      try {
        yield AadhaarBackLoadingState();
        await apiService.uploadFilesAndImages(file: event.img,fileName:'Aadhaar Back',ph: '9790348843');

        yield AadhaarBackSuccessState();
      }catch(e){
        print("Came insdei Falilure state ${e.toString()}");
        yield AadhaarBackFailureState();
      }
    }



  }

}