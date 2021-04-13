import 'package:equatable/equatable.dart';
import 'package:paisa_takatak_mobile/bloc/emi_bloc/emi_event.dart';

abstract class EmiState extends Equatable{
}

class EmiInitialState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ZeroEmiState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class OneEmiState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class TwoEmiState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class ThreeEmiState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class EmiLoadingState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}


class EmiFailureState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}


class EmiSuccessState extends EmiState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

