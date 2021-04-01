import 'package:equatable/equatable.dart';

abstract class AgreementOtpEvent extends Equatable{}


class AgreementSendOtpEvent extends AgreementOtpEvent{

  String phNo;

  AgreementSendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[phNo];
}


class AgreementVerifyOtpEvent extends AgreementOtpEvent{

  String pin,phNo;

  AgreementVerifyOtpEvent({this.pin,this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[pin];

}


class AgreementResendOtpEvent extends AgreementOtpEvent{

  String phNo;

  AgreementResendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[phNo];

}







