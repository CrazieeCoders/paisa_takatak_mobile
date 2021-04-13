import 'package:equatable/equatable.dart';

abstract class NetworkState{}

class ConnectionInitial extends NetworkState{}

class ConnectionSuccess extends NetworkState{}

class ConnectionFailure extends NetworkState{}

