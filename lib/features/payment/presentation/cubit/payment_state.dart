import 'package:equatable/equatable.dart';
import '../../domain/models/country_payment.dart';

enum PaymentStatus { idle, processing, success, failure }

class PaymentState extends Equatable {
  final CountryPayment? selectedCountry;
  final PaymentMethodType? selectedMethod;
  final PaymentStatus status;
  final String? error;

  const PaymentState({
    this.selectedCountry,
    this.selectedMethod,
    this.status = PaymentStatus.idle,
    this.error,
  });

  bool get canPay => selectedCountry != null && selectedMethod != null;

  PaymentState copyWith({
    CountryPayment? selectedCountry,
    PaymentMethodType? selectedMethod,
    PaymentStatus? status,
    String? error,
    bool clearError = false,
  }) {
    return PaymentState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      status: status ?? this.status,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props =>
      [selectedCountry, selectedMethod, status, error];
}
