import 'network_state.dart';

abstract class NetworkEvent {}

class ListenConnection extends NetworkEvent{}


class ConnectionChanged extends NetworkEvent{

   NetworkState networkState;
   ConnectionChanged(this.networkState);
}