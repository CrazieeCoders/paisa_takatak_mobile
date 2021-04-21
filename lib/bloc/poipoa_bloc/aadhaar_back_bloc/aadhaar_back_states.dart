import 'package:equatable/equatable.dart';

abstract class AadhaarBackState extends Equatable{}

class AadhaarBackInitialState extends AadhaarBackState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class AadhaarBackSuccessState extends AadhaarBackState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class AadhaarBackFailureState extends AadhaarBackState{

  String errMsg;

  AadhaarBackFailureState({this.errMsg});
  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];

}

class AadhaarBackLoadingState extends AadhaarBackState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}