import 'package:equatable/equatable.dart';
import 'dart:math';

Random random = new Random();

abstract class AgreementOtpState extends Equatable{}


class AgreementOtpInitialState extends AgreementOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class AgreementSendOtpState extends AgreementOtpState{

  String sendOtp;

  AgreementSendOtpState({this.sendOtp});

  @override
  // TODO: implement props
  List<Object> get props =>[sendOtp];
}

class AgreementOtpLoadingState extends AgreementOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class AgreementOtpErrorState extends AgreementOtpState{
  String errMsg;

  AgreementOtpErrorState({this.errMsg});
  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];
}

class AgreementOtpSuccessState extends AgreementOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class AgreementOtpFailureState extends AgreementOtpState{
  int randomNumber = random.nextInt(100);
  @override
  // TODO: implement props
  List<Object> get props =>[randomNumber];


}


class AgreementResendOtpSuccessState extends AgreementOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}


