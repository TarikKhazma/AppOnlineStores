import 'dart:io' show Platform;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'core/constants/app_string.dart';
import 'core/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/language/cubit/language_cubit.dart';
import 'features/products/presentation/cubit/product_cubit.dart';
import 'features/products/presentation/pages/products_page.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQLite FFI for Windows / Linux / macOS desktop
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  setupDependencies();

  runApp(
    DevicePreview(
      enabled: kDebugMode,
      builder: (context) => const OnlineStoreApp(),
    ),
  );
}

class OnlineStoreApp extends StatelessWidget {
  const OnlineStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProductCubit>()),
        BlocProvider(
          create: (_) => LanguageCubit()..loadSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: DevicePreview.appBuilder,
            home: const ProductsPage(),
          );
        },
      ),
    );
  }
}
