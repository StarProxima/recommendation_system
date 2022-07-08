import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';

void main() {
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
        disabledColor: AppColors.disabled,
        iconTheme: const IconThemeData(
          color: AppColors.text,
          opacity: 1,
          size: 24,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              titleLarge: const TextStyle(
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recommendation system'),
        ),
        body: const Text('Recommendation system'),
      ),
    );
  }
}
