import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../cubit/product_cubit.dart';
import '../widgets/add_product_sheet.dart';

class ProductsFAB extends StatelessWidget {
  const ProductsFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return FloatingActionButton.extended(
      onPressed: () => _openAddSheet(context),
      icon: const Icon(Icons.add_rounded),
      label: Text(l10n.addProduct, style: AppTextStyles.buttonText),
    );
  }

  void _openAddSheet(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    final languageCubit = context.read<LanguageCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: productCubit),
          BlocProvider.value(value: languageCubit),
        ],
        child: const AddProductSheet(),
      ),
    );
  }
}
