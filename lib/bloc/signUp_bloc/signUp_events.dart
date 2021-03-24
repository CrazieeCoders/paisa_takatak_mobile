import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable{}


class SendOtpEvent extends OtpEvent{

  String phNo;

  SendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[phNo];
}


class VerifyOtpEvent extends OtpEvent{

  String pin;

  VerifyOtpEvent({this.pin});

  @override
  // TODO: implement props
  List<Object> get props =>[pin];

}


class ResendOtpEvent extends OtpEvent{

  String phNo;

  ResendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[phNo];

}







