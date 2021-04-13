import 'package:equatable/equatable.dart';

abstract class BankStatState extends Equatable{}

class BankStatInitialState extends BankStatState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class BankStatSuccessState extends BankStatState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class BankStatFailureState extends BankStatState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class BankStatLoadingState extends BankStatState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}