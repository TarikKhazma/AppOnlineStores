import 'package:flutter/material.dart';
import 'translations_ar.dart';
import 'translations_en.dart';

/// Loads strings from the matching translations file.
class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const delegate = _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('en'), Locale('ar')];

  /// Active translation map — either [translationsEn] or [translationsAr].
  Map<String, String> get _t =>
      locale.languageCode == 'ar' ? translationsAr : translationsEn;

  // App
  String get appName => _t['appName']!;
  String get products => _t['products']!;

  // Product actions 
  String get addProduct => _t['addProduct']!;
  String get deleteProduct => _t['deleteProduct']!;
  String get deleteConfirmation => _t['deleteConfirmation']!;
  String get productAdded => _t['productAdded']!;
  String get productDeleted => _t['productDeleted']!;

  // Form fields 
  String get productTitle => _t['productTitle']!;
  String get productPrice => _t['productPrice']!;
  String get productDescription => _t['productDescription']!;
  String get productCategory => _t['productCategory']!;
  String get productImage => _t['productImage']!;
  String get required => _t['required']!;
  String get invalidPrice => _t['invalidPrice']!;

  // States 
  String get loading => _t['loading']!;
  String get errorOccurred => _t['errorOccurred']!;
  String get noProducts => _t['noProducts']!;
  String get addFirstProduct => _t['addFirstProduct']!;

  // Buttons 
  String get retry => _t['retry']!;
  String get cancel => _t['cancel']!;
  String get delete => _t['delete']!;
  String get refresh => _t['refresh']!;

  // Labels 
  String get items => _t['items']!;
  String get reviews => _t['reviews']!;
  String get newLabel => _t['newLabel']!;
  String get description => _t['description']!;

  /// Label shown on the toggle button — always shows the OTHER language name.
  String get toggleLanguageLabel => _t['toggleLanguageLabel']!;
}

// Delegate

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// ─── BuildContext extension ───────────────────────────────────────────────────

extension BuildContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
