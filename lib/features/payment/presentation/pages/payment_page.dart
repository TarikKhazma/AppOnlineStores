import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart' show CreditCardWidget, CreditCardForm;
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../domain/models/country_payment.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';
import '../widgets/address_form.dart';
import '../widgets/country_selector.dart';
import '../widgets/payment_method_selector.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: const _PaymentView(),
    );
  }
}

class _PaymentView extends StatelessWidget {
  const _PaymentView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) {
        final l10n = context.l10n;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.payment, style: AppTextStyles.appBarTitle),
          ),
          body: BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state.status == PaymentStatus.success) {
                context.read<CartCubit>().clear();
                _showSuccess(context, l10n);
              }
            },
            builder: (context, state) {
              if (state.status == PaymentStatus.processing) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              return _PaymentForm(state: state, l10n: l10n);
            },
          ),
        );
      },
    );
  }

  void _showSuccess(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded,
                color: AppColors.success, size: 72),
            const SizedBox(height: AppSizes.md),
            Text(l10n.orderPlaced,
                style: AppTextStyles.titleMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.xs),
            Text(l10n.orderPlacedSubtitle,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: AppSizes.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(l10n.backToShopping),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Payment Form

class _PaymentForm extends StatefulWidget {
  const _PaymentForm({required this.state, required this.l10n});
  final PaymentState state;
  final AppLocalizations l10n;

  @override
  State<_PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<_PaymentForm> {
  final _addressFormKey = GlobalKey<FormState>();
  final _cardFormKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _cardHolder = '';
  String _expiryDate = '';
  String _cvv = '';
  bool _isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    final isCard = widget.state.selectedMethod == PaymentMethodType.creditCard;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Summary
          _OrderSummaryCard(l10n: widget.l10n),
          const SizedBox(height: AppSizes.md),

          // Delivery address
          AddressForm(formKey: _addressFormKey),
          const SizedBox(height: AppSizes.md),

          // Country
          const CountrySelector(),
          const SizedBox(height: AppSizes.md),

          // Payment Method
          const PaymentMethodSelector(),

          // Credit Card form
          if (isCard) ...[
            const SizedBox(height: AppSizes.md),
            CreditCardWidget(
              cardNumber: _cardNumber,
              expiryDate: _expiryDate,
              cardHolderName: _cardHolder,
              cvvCode: _cvv,
              showBackView: _isCvvFocused,
              onCreditCardWidgetChange: (_) {},
              isSwipeGestureEnabled: true,
            ),
            CreditCardForm(
              formKey: _cardFormKey,
              cardNumber: _cardNumber,
              expiryDate: _expiryDate,
              cardHolderName: _cardHolder,
              cvvCode: _cvv,
              onCreditCardModelChange: (model) {
                setState(() {
                  _cardNumber = model.cardNumber;
                  _expiryDate = model.expiryDate;
                  _cardHolder = model.cardHolderName;
                  _cvv = model.cvvCode;
                  _isCvvFocused = model.isCvvFocused;
                });
              },
            ),
          ],

          const SizedBox(height: AppSizes.lg),

          // Pay button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.state.canPay
                  ? () {
                      final addressOk =
                          _addressFormKey.currentState?.validate() == true;
                      if (!addressOk) return;
                      if (isCard &&
                          _cardFormKey.currentState?.validate() != true) {
                        return;
                      }
                      context.read<PaymentCubit>().pay();
                    }
                  : null,
              icon: const Icon(Icons.lock_rounded),
              label: Text(widget.l10n.payNow),
            ),
          ),
          const SizedBox(height: AppSizes.navBarClearance),
        ],
      ),
    );
  }
}

// Order Summary Card 

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.orderSummary, style: AppTextStyles.titleSmall),
                const SizedBox(height: AppSizes.sm),
                ...state.items.map(
                  (item) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.quantity}× ${item.product.title}',
                            style: AppTextStyles.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '\$${item.totalPrice.toStringAsFixed(2)}',
                          style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.total, style: AppTextStyles.titleSmall),
                    Text(
                      '\$${state.totalPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.price,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
