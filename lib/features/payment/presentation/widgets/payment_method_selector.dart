import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/models/country_payment.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final country = state.selectedCountry;
        if (country == null) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.selectPaymentMethod, style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSizes.sm),
            ...country.methods.map(
              (method) => _MethodTile(
                method: method,
                isSelected: state.selectedMethod == method,
                l10n: l10n,
                onTap: () =>
                    context.read<PaymentCubit>().selectMethod(method),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.method,
    required this.isSelected,
    required this.l10n,
    required this.onTap,
  });

  final PaymentMethodType method;
  final bool isSelected;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCash = method == PaymentMethodType.cash;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.05)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : AppColors.shimmer,
                  borderRadius:
                      BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(
                  isCash
                      ? Icons.local_shipping_rounded
                      : Icons.credit_card_rounded,
                  color:
                      isSelected ? AppColors.primary : AppColors.textLight,
                  size: AppSizes.iconMd,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCash ? l10n.cash : l10n.creditCard,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      isCash ? l10n.cashSubtitle : l10n.creditCardSubtitle,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                    width: 2,
                  ),
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
