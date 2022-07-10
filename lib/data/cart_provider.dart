import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recommendation_system/data/product_model.dart';

class CartProvider extends InheritedNotifier<CartModel> {
  const CartProvider({Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child);

  final CartModel model;

  static CartModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>()?.model;
  }
}

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get poducts {
    return _products;
  }

  int get sum {
    int s = 0;
    for (var element in poducts) {
      s += element.price.toInt();
    }
    return s;
  }

  void add(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    notifyListeners();
  }

  List<Map<String, dynamic>> toJson() {
    return List.generate(
      poducts.length,
      (index) => {
        'name': poducts[index].name,
        'cost': poducts[index].price,
        'merchantName': poducts[index].price,
      },
    );
  }
}
