import 'package:equatable/equatable.dart';

abstract class LoanFormState extends Equatable{}


class LoanFromInitialState extends LoanFormState{


  @override
  // TODO: implement props
  List<Object> get props =>[];
}



class LoanFormSuccessState extends LoanFormState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class LoanFormFailureState extends LoanFormState{

  String errMsg;

  LoanFormFailureState({this.errMsg});
  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];
}


class LoanFormLoadingState extends LoanFormState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}