import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:recommendation_system/data/recommendation_repository.dart';

import '../../data/product_model.dart';
import '../widgets/product_card.dart';

class StockPage extends StatefulWidget {
  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final LiveOptions options = const LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 35),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.025,
    reAnimateOnVisibility: false,
  );

  late var stockProducts = [];
  late double itemWidth;

  void loadStockProducts() async {
    stockProducts = await RecommendationRepository.getRecommendations() ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadStockProducts();
  }

  @override
  Widget build(BuildContext context) {
    itemWidth = (MediaQuery.of(context).size.width - 3 * 16) / 2;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            stockBanner,
            const SizedBox(height: 8),
            stockTitle,
            const SizedBox(height: 8),
            stockDescription,
            const SizedBox(height: 32),
            stockProductsWidget,
          ],
        ),
      ),
    );
  }

  Widget get stockBanner => Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 16),
        height: 196,
        constraints: const BoxConstraints(minWidth: double.infinity),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Image(image: AppImages.cart),
      );

  Widget get stockTitle => Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 0),
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text(
          "Название акции",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
      );

  Widget get stockDescription => Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 0),
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text(
          "Описание акции",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget get stockProductsWidget => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 0),
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text(
              "Товары, учавствующие\nв акции",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
            itemCount: stockProducts.length,
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
                      name: stockProducts[index].name,
                      price: stockProducts[index].price,
                      merchant: stockProducts[index].merchant,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
}
