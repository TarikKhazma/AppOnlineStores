import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../../payment/presentation/pages/payment_page.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) {
        final l10n = context.l10n;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.cart, style: AppTextStyles.appBarTitle),
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.isEmpty) return _EmptyCart(l10n: l10n);
              return _CartContent(state: state, l10n: l10n);
            },
          ),
        );
      },
    );
  }
}

//Empty State 

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: AppSizes.iconXxl, color: AppColors.textLight),
          const SizedBox(height: AppSizes.md),
          Text(l10n.cartEmpty, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSizes.xs),
          Text(l10n.cartEmptySubtitle,
              style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// Cart Content 

class _CartContent extends StatelessWidget {
  const _CartContent({required this.state, required this.l10n});
  final CartState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              top: AppSizes.sm,
              bottom: AppSizes.xxl + AppSizes.lg,
            ),
            itemCount: state.items.length,
            itemBuilder: (_, i) => CartItemCard(item: state.items[i]),
          ),
        ),
        _OrderSummary(state: state, l10n: l10n),
      ],
    );
  }
}

// Order Summary 

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.state, required this.l10n});
  final CartState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSizes.md, AppSizes.md, AppSizes.md, AppSizes.navBarClearance),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXl)),
      ),
      child: Column(
        children: [
          _SummaryRow(label: l10n.subtotal,
              value: '\$${state.totalPrice.toStringAsFixed(2)}'),
          const SizedBox(height: AppSizes.xs),
          _SummaryRow(label: l10n.shipping, value: l10n.free,
              valueColor: AppColors.success),
          const Divider(height: AppSizes.md),
          _SummaryRow(
            label: l10n.total,
            value: '\$${state.totalPrice.toStringAsFixed(2)}',
            isBold: true,
          ),
          const SizedBox(height: AppSizes.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PaymentPage())),
              icon: const Icon(Icons.payment_rounded),
              label: Text(l10n.checkout),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final style = isBold ? AppTextStyles.titleSmall : AppTextStyles.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value,
            style: style.copyWith(
                color: valueColor ?? (isBold ? AppColors.primary : null))),
      ],
    );
  }
}
