import 'package:equatable/equatable.dart';
import 'package:paisa_takatak_mobile/model/registeration_model.dart';

abstract class LoanFormEvent extends Equatable{}

class AddLoanFormEvent extends LoanFormEvent{

  RegisterationInfo registerationInfo;

  AddLoanFormEvent({this.registerationInfo});

  @override
  // TODO: implement props
  List<Object> get props =>[];
}
