import 'package:equatable/equatable.dart';

abstract class ChequeState extends Equatable{}

class ChequeInitialState extends ChequeState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class ChequeSuccessState extends ChequeState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class ChequeFailureState extends ChequeState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class ChequeLoadingState extends ChequeState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}