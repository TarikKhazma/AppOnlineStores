import 'package:flutter/material.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l10n.required : null;

    String? phone(String? v) {
      if (v == null || v.trim().isEmpty) return l10n.required;
      final digits = v.replaceAll(RegExp(r'\D'), '');
      return digits.length < 7 ? l10n.invalidPhone : null;
    }

    String? email(String? v) {
      if (v == null || v.trim().isEmpty) return l10n.required;
      return (!v.contains('@') || !v.contains('.'))
          ? l10n.invalidEmail
          : null;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_shipping_outlined, size: AppSizes.iconMd),
                  const SizedBox(width: AppSizes.xs),
                  Text(l10n.deliveryDetails, style: AppTextStyles.titleSmall),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.fullAddress,
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                validator: required,
              ),
              const SizedBox(height: AppSizes.sm),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: l10n.houseNumber,
                        prefixIcon: const Icon(Icons.home_outlined),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: required,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: l10n.phoneNumber,
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: email,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
