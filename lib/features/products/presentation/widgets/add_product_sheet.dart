import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product_cubit.dart';

class AddProductSheet extends StatefulWidget {
  const AddProductSheet({super.key});

  @override
  State<AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<AddProductSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _categoryCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) => _buildSheet(context),
    );
  }

  Widget _buildSheet(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSizes.bottomSheetRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandle(),
            _buildHeader(context, l10n),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.lg, 0, AppSizes.lg, AppSizes.lg,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _field(
                        ctrl: _titleCtrl,
                        label: l10n.productTitle,
                        icon: Icons.title_rounded,
                        validator: (v) => _required(v, context),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      _field(
                        ctrl: _priceCtrl,
                        label: l10n.productPrice,
                        icon: Icons.attach_money_rounded,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return _required(v, context);
                          if (double.tryParse(v) == null) {
                            return l10n.invalidPrice;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSizes.sm),
                      _field(
                        ctrl: _categoryCtrl,
                        label: l10n.productCategory,
                        icon: Icons.category_rounded,
                        validator: (v) => _required(v, context),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      _field(
                        ctrl: _imageCtrl,
                        label: l10n.productImage,
                        icon: Icons.image_rounded,
                        validator: (v) => _required(v, context),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      _field(
                        ctrl: _descCtrl,
                        label: l10n.productDescription,
                        icon: Icons.description_rounded,
                        maxLines: 3,
                        validator: (v) => _required(v, context),
                      ),
                      const SizedBox(height: AppSizes.lg),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submit,
                          icon: const Icon(Icons.add_rounded),
                          label: Text(l10n.addProduct),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value, BuildContext context) =>
      (value == null || value.trim().isEmpty) ? context.l10n.required : null;

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      width: AppSizes.handleWidth,
      height: AppSizes.handleHeight,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSizes.lg, 0, AppSizes.sm, AppSizes.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.sm),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Icon(
              Icons.add_shopping_cart_rounded,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Text(l10n.addProduct, style: AppTextStyles.titleMedium),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController ctrl,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon:
            Icon(icon, color: AppColors.primary, size: AppSizes.iconMd),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;

    final product = ProductEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleCtrl.text.trim(),
      price: double.parse(_priceCtrl.text.trim()),
      description: _descCtrl.text.trim(),
      category: _categoryCtrl.text.trim(),
      image: _imageCtrl.text.trim(),
      isLocal: true,
    );

    context.read<ProductCubit>().addProduct(product);
    Navigator.pop(context);
  }
}
