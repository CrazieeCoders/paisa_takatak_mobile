import 'package:equatable/equatable.dart';
import 'package:paisa_takatak_mobile/model/household_model.dart';

enum Emi {
  zero,
  one,
  two,
  three
}


abstract class EmiEvent extends Equatable{
}


class SelectEmiEvent extends EmiEvent{

  String emi;

  SelectEmiEvent({this.emi});

  @override
  // TODO: implement props
  List<Object> get props =>[emi];

}


class SubmitEmiEvent extends EmiEvent{

  HouseHold houseHold;

  SubmitEmiEvent({this.houseHold});

  @override
  // TODO: implement props
  List<Object> get props =>[houseHold];

}