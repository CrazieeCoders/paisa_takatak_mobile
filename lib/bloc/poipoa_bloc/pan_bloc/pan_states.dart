import 'package:equatable/equatable.dart';

abstract class PanState extends Equatable{}

class PanInitialState extends PanState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class PanSuccessState extends PanState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class PanFailureState extends PanState{

  String errMsg;

  PanFailureState({this.errMsg});

  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];

}

class PanLoadingState extends PanState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}