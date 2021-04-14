import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paisa_takatak_mobile/bloc/emi_bloc/emi_event.dart';
import 'package:paisa_takatak_mobile/bloc/payment_bloc/payment_events.dart';
import 'package:paisa_takatak_mobile/bloc/payment_bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent,PaymentState>{


  PaymentBloc() : super(PaymentInitialState());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async*{
    // TODO: implement mapEventToState

    if(event is SelectPayment){
      switch(event.payment){
        case 'Credit Card/Debit Card':
          yield CardState();
          break;
        case 'Net Banking':
          yield NetBankingState();
          break;
        case 'Upi Payment':
          yield UpiState();
          break;
        default:
          yield CardState();
        break;
      }
    }


  }
}