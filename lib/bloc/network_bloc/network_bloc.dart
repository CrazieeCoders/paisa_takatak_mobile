import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network_event.dart';
import 'network_state.dart';


class NetworkBloc extends Bloc<NetworkEvent,NetworkState>{
  
  
  NetworkBloc() : super(ConnectionInitial());
  StreamSubscription _streamSubscription;

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async*{

        if(event is ListenConnection){
               _streamSubscription =DataConnectionChecker().onStatusChange.listen((status) {

                add(ConnectionChanged(status == DataConnectionStatus.disconnected ?
                ConnectionFailure():
                ConnectionSuccess(),
                ));

               });
        }


        if(event is ConnectionChanged){
              yield event.networkState;
        }

  }

  @override
  Future<void> close() {
    // TODO: implement close
    _streamSubscription?.cancel();
    return super.close();
  }




  
  
}
