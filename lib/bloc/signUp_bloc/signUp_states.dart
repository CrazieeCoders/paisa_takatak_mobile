import 'package:equatable/equatable.dart';
import 'dart:math';

Random random = new Random();

abstract class OtpState extends Equatable{}


class OtpInitialState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class SendOtpState extends OtpState{

  String sendOtp;

  SendOtpState({this.sendOtp});

  @override
  // TODO: implement props
  List<Object> get props =>[sendOtp];
}

class OtpLoadingState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class OtpErrorState extends OtpState{
  String errMsg;

  OtpErrorState({this.errMsg});
  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];
}

class OtpSuccessState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class OtpFailureState extends OtpState{
  int randomNumber = random.nextInt(100);
  @override
  // TODO: implement props
  List<Object> get props =>[randomNumber];


}


class ResendOtpSuccessState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class LoanAgreementPageOtpState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}



class HouseHoldPageState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}



class LoanConfirmationPageOtpState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class PoiPoaPageOtpState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class LoanFormPageOtpState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class HouseholdPageOtpState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class PaymentPageOtpState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}












class LoanApplicationSuccessState extends OtpState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}


