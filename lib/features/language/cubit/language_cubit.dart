import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  static const _prefKey = 'language_code';

  LanguageCubit() : super(const Locale('en'));

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefKey) ?? 'en';
    emit(Locale(code));
  }

  Future<void> toggleLanguage() async {
    final newCode = state.languageCode == 'en' ? 'ar' : 'en';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, newCode);
    emit(Locale(newCode));
  }
}
