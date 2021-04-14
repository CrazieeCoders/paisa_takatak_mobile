import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable{}


class SelectPayment extends PaymentEvent{

  String payment;

  SelectPayment({this.payment});

  @override
  // TODO: implement props
  List<Object> get props =>[];

}