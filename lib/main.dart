import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/ui/pages/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.background,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recommendation system',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        secondaryHeaderColor: AppColors.headlineText,
        disabledColor: AppColors.disabled,
        appBarTheme: AppBarTheme.of(context).copyWith(
          color: Colors.white,
          iconTheme: const IconThemeData(
            color: AppColors.headlineText,
          ),
          titleTextStyle: const TextStyle(
            color: AppColors.headlineText,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.headlineText,
          opacity: 1,
          size: 24,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              titleLarge: const TextStyle(
                color: AppColors.headlineText,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              titleMedium: const TextStyle(
                letterSpacing: 0,
                color: AppColors.disabledtext,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
              titleSmall: const TextStyle(
                letterSpacing: 0,
                color: AppColors.headlineText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
              headlineLarge: const TextStyle(
                color: AppColors.headlineText,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontFamily: 'Inter',
              ),
              headlineMedium: const TextStyle(
                color: AppColors.headlineText,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
              headlineSmall: const TextStyle(
                color: AppColors.headlineText,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
              labelMedium: const TextStyle(
                color: AppColors.headlineText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
              labelSmall: const TextStyle(
                letterSpacing: 0,
                color: AppColors.disabledtext,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
      ),
      home: const HomePage(),
    );
  }
}
