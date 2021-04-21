import 'package:equatable/equatable.dart';

abstract class AadhaarFrontState extends Equatable{}

class AadhaarFrontInitialState extends AadhaarFrontState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class AadhaarFrontSuccessState extends AadhaarFrontState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class AadhaarFrontFailureState extends AadhaarFrontState{

  String errMsg;

  AadhaarFrontFailureState({this.errMsg});

  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];

}

class AadhaarFrontLoadingState extends AadhaarFrontState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}