import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/country_payment.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  void selectCountry(CountryPayment country) {
    emit(state.copyWith(
      selectedCountry: country,
      selectedMethod: null,
    ));
  }

  void selectMethod(PaymentMethodType method) {
    emit(state.copyWith(selectedMethod: method));
  }

  Future<void> pay() async {
    if (!state.canPay) return;
    emit(state.copyWith(status: PaymentStatus.processing));
    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: PaymentStatus.success));
  }

  void reset() => emit(const PaymentState());
}
