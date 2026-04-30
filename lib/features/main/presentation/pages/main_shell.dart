import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/widgets/floating_nav_bar.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../language/cubit/language_cubit.dart';
import '../../../products/presentation/pages/products_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const _pages = [
    ProductsPage(),
    CartPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, _) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return Scaffold(
              body: Stack(
                children: [
                  IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                  Positioned(
                    bottom: AppSizes.lg,
                    left: 0,
                    right: 0,
                    child: FloatingNavBar(
                      currentIndex: _currentIndex,
                      cartCount: cartState.totalCount,
                      onTap: (i) => setState(() => _currentIndex = i),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
