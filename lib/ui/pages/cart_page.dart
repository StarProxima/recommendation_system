import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/cart_provider.dart';

import 'package:recommendation_system/data/recommendation_repository.dart';
import 'package:recommendation_system/ui/pages/search_page.dart';
import 'package:recommendation_system/ui/widgets/banner_viewer.dart';
import 'package:recommendation_system/ui/widgets/product_card.dart';
import 'package:auto_animated/auto_animated.dart';

import '../../data/product_model.dart';
import '../widgets/search_panel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final LiveOptions options = const LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 35),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.025,
    reAnimateOnVisibility: false,
  );

  List<Product> recomendedProducts = [];

  bool isSuccessfulPayment = false;

  Future<void> postPlayment() async {
    String json = jsonEncode(CartProvider.of(context)!);

    await RecommendationRepository.postPlayment(json);
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    setState(() {
      recomendedProducts.clear();
      isSuccessfulPayment = true;
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (MediaQuery.of(context).size.width - 3 * 16) / 2;
    var width = MediaQuery.of(context).size.width;
    recomendedProducts = CartProvider.of(context)!.poducts;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSuccessfulPayment ? Colors.green : AppColors.headlineText,
        ),
        height: 50,
        width: width - 32,
        child: TextButton(
          onPressed: () {
            setState(() {
              postPlayment();
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: Colors.white,
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: Center(
            child: Text(
              isSuccessfulPayment
                  ? 'Успешно'
                  : recomendedProducts.isEmpty
                      ? 'Добавьте что-нибудь в корзину'
                      : '${CartProvider.of(context)!.sum}₽   •   Купить',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Text(
                  "Корзина",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              LiveGrid.options(
                options: options,
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 40,
                  left: 16,
                  right: 16,
                ),
                itemCount: recomendedProducts.length,
                primary: false,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: itemWidth / (itemWidth + 119),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: ProductCard(
                        width: itemWidth,
                        product: Product(
                          name: recomendedProducts[index].name,
                          price: recomendedProducts[index].price,
                          merchant: recomendedProducts[index].merchant,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
