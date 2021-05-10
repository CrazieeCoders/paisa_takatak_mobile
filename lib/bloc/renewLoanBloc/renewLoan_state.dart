import 'package:equatable/equatable.dart';
import 'dart:math';

Random random = new Random();

abstract class RenewOtpState extends Equatable{}


class RenewOtpInitialState extends RenewOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class RenewSendOtpState extends RenewOtpState{

  String sendOtp;

  RenewSendOtpState({this.sendOtp});

  @override
  // TODO: implement props
  List<Object> get props =>[sendOtp];
}

class RenewOtpLoadingState extends RenewOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class RenewOtpErrorState extends RenewOtpState{
  String errMsg;

  RenewOtpErrorState({this.errMsg});
  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];
}

class RenewOtpSuccessState extends RenewOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class RenewOtpFailureState extends RenewOtpState{
  int randomNumber = random.nextInt(100);
  @override
  // TODO: implement props
  List<Object> get props =>[randomNumber];


}


class RenewResendOtpSuccessState extends RenewOtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}


