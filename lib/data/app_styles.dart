// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFFED0148);
  static const headlineText = Color(0xFF323043);
  static const disabledtext = Color(0XFF817F8F);
  static const disabled = Color(0XFF817F8F);
  static const background = Color(0xFFF4F4F4);
  static const shadow = Color(0x40E0E0E0);
  static const divider = Color(0xFFEBEAF2);
  static const cashback = Color(0xFF8C40C9);
}

abstract class AppImages {
  static const cart = AssetImage('assets/cart.png');

  static AssetImage shopImage(String shopName) {
    switch (shopName) {
      case "Магнит":
        return const AssetImage('assets/магнит.png');
      case "Пятёрочка":
        return const AssetImage('assets/пятерочка.png');
      case "STEAM":
        return const AssetImage('assets/стим.png');
    }
    return AppImages.cart;
  }

  static AssetImage productImage(String productName) {
    switch (productName) {
      case "Леденцы":
        return const AssetImage('assets/ledenci.jpg');
      case "Лимон":
        return const AssetImage('assets/limon.png');
      case "Лук":
        return const AssetImage('assets/luk.jpg');
      case "Пиво":
        return const AssetImage('assets/pivo.jpg');
      case "Вареники":
        return const AssetImage('assets/вареники.jpg');
      case "Лимонад":
        return const AssetImage('assets/лимонад.jpg');
      case "Свинина":
        return const AssetImage('assets/свинина.jpg');
      case "Батончики":
        return const AssetImage('assets/батончики.jpg');
      case "Виски":
        return const AssetImage('assets/виски.jpg');
      case "Хлебцы":
        return const AssetImage('assets/хлебцы.jpeg');
      case "Мандарины":
        return const AssetImage('assets/мандарины.jpg');
      case "Пельмени":
        return const AssetImage('assets/пельмени.jpeg');
      case "Кефир":
        return const AssetImage('assets/кефир.jpg');
      case "Огурцы":
        return const AssetImage('assets/огурцы.jpg');
      case "Яблоко":
        return const AssetImage('assets/яблоко.jpg');
      case "Молоко":
        return const AssetImage('assets/молоко.jpeg');
      case "Шоколад":
        return const AssetImage('assets/шоколад.jpeg');
      case "Сыр":
        return const AssetImage('assets/сыр.jpeg');
      case "Апельсины":
        return const AssetImage('assets/апельсины.jpg');
      case "Картофель фри":
        return const AssetImage('assets/картофель_фри.jpg');
    }
    return AppImages.cart;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
