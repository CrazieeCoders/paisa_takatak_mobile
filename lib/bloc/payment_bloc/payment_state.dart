import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable{}


class PaymentInitialState extends PaymentState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CardState extends PaymentState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class UpiState extends PaymentState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class NetBankingState extends PaymentState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}
