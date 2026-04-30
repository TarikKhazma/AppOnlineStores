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

  // Navigation
  String get home => _t['home']!;
  String get cart => _t['cart']!;
  String get favorites => _t['favorites']!;

  // Cart
  String get addToCart => _t['addToCart']!;
  String get removeFromCart => _t['removeFromCart']!;
  String get cartEmpty => _t['cartEmpty']!;
  String get cartEmptySubtitle => _t['cartEmptySubtitle']!;
  String get checkout => _t['checkout']!;
  String get total => _t['total']!;
  String get subtotal => _t['subtotal']!;
  String get shipping => _t['shipping']!;
  String get free => _t['free']!;
  String get quantity => _t['quantity']!;
  String get continueShopping => _t['continueShopping']!;
  String get addedToCart => _t['addedToCart']!;
  String get removedFromCart => _t['removedFromCart']!;

  // Favorites
  String get addedToFavorites => _t['addedToFavorites']!;
  String get removedFromFavorites => _t['removedFromFavorites']!;
  String get favoritesEmpty => _t['favoritesEmpty']!;
  String get favoritesEmptySubtitle => _t['favoritesEmptySubtitle']!;

  // Payment
  String get payment => _t['payment']!;
  String get paymentMethod => _t['paymentMethod']!;
  String get selectPaymentMethod => _t['selectPaymentMethod']!;
  String get cash => _t['cash']!;
  String get cashSubtitle => _t['cashSubtitle']!;
  String get creditCard => _t['creditCard']!;
  String get creditCardSubtitle => _t['creditCardSubtitle']!;
  String get selectCountry => _t['selectCountry']!;
  String get country => _t['country']!;
  String get cardNumber => _t['cardNumber']!;
  String get cardHolder => _t['cardHolder']!;
  String get expiryDate => _t['expiryDate']!;
  String get cvv => _t['cvv']!;
  String get payNow => _t['payNow']!;
  String get orderSummary => _t['orderSummary']!;
  String get orderPlaced => _t['orderPlaced']!;
  String get orderPlacedSubtitle => _t['orderPlacedSubtitle']!;
  String get backToShopping => _t['backToShopping']!;
  String get availableIn => _t['availableIn']!;

  // Delivery
  String get deliveryDetails => _t['deliveryDetails']!;
  String get fullAddress => _t['fullAddress']!;
  String get houseNumber => _t['houseNumber']!;
  String get phoneNumber => _t['phoneNumber']!;
  String get email => _t['email']!;
  String get invalidPhone => _t['invalidPhone']!;
  String get invalidEmail => _t['invalidEmail']!;
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
