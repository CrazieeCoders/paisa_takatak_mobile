import 'package:equatable/equatable.dart';

abstract class RenewOtpEvent extends Equatable{}


class RenewSendOtpEvent extends RenewOtpEvent{

  String phNo;

  RenewSendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[phNo];
}


class RenewVerifyOtpEvent extends RenewOtpEvent{

  String pin,phNo;

  RenewVerifyOtpEvent({this.pin,this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[pin];

}


class RenewResendOtpEvent extends RenewOtpEvent{

  String phNo;

  RenewResendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[phNo];

}







