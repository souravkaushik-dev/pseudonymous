import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get light => TextTheme(
    displayLarge: GoogleFonts.urbanist(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    displayMedium: GoogleFonts.urbanist(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    headlineLarge: GoogleFonts.urbanist(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    headlineMedium: GoogleFonts.urbanist(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    titleLarge: GoogleFonts.urbanist(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    titleMedium: GoogleFonts.urbanist(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    bodyLarge: GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),

    bodyMedium: GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),

    bodySmall: GoogleFonts.urbanist(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),

    labelLarge: GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.surface,
    ),

    labelMedium: GoogleFonts.urbanist(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    ),
  );

  static TextTheme get dark => light.apply(
    bodyColor: AppColors.darkTextPrimary,
    displayColor: AppColors.darkTextPrimary,
  );
}