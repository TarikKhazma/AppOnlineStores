import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color.dart';
import '../constants/app_size.dart';

class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.poppins(
        fontSize: AppSizes.fontDisplay,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle get headlineLarge => GoogleFonts.poppins(
        fontSize: AppSizes.fontXxl,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: AppSizes.fontXl,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleMedium => GoogleFonts.poppins(
        fontSize: AppSizes.fontLg,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleSmall => GoogleFonts.poppins(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: AppSizes.fontSm,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get labelLarge => GoogleFonts.poppins(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      );

  static TextStyle get price => GoogleFonts.poppins(
        fontSize: AppSizes.fontLg,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  static TextStyle get priceDisplay => GoogleFonts.poppins(
        fontSize: AppSizes.fontXxl,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: AppSizes.fontXs,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      );

  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.3,
      );

  static TextStyle get badge => GoogleFonts.poppins(
        fontSize: AppSizes.fontXs,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.5,
      );

  static TextStyle get appBarTitle => GoogleFonts.poppins(
        fontSize: AppSizes.fontXl,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
}
