import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/models/country_payment.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).languageCode;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final selected = state.selectedCountry;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.selectCountry, style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSizes.sm),
            InkWell(
              onTap: () => _showPicker(context, lang),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.sm + 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected != null
                        ? AppColors.primary
                        : AppColors.divider,
                    width: selected != null ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Row(
                  children: [
                    if (selected != null) ...[
                      Text(selected.flag,
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: AppSizes.sm),
                    ],
                    Expanded(
                      child: Text(
                        selected?.localName(lang) ?? l10n.selectCountry,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: selected != null
                              ? AppColors.textPrimary
                              : AppColors.textLight,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_rounded,
                        color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPicker(BuildContext context, String lang) {
    final cubit = context.read<PaymentCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.bottomSheetRadius)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (_, controller) => ListView.builder(
          controller: controller,
          itemCount: supportedCountries.length,
          itemBuilder: (_, i) {
            final c = supportedCountries[i];
            return ListTile(
              leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
              title:
                  Text(c.localName(lang), style: AppTextStyles.bodyLarge),
              onTap: () {
                cubit.selectCountry(c);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
