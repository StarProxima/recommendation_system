// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFFED0148);
  static const headlineText = Color(0xFF323043);
  static const disabledtext = Color(0XFF817F8F);
  static const disabled = Color(0XFF817F8F);
  static const background = Color(0xFFF4F4F4);
}

abstract class AppImages {
  static const cart = AssetImage('assets/cart.png');
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
