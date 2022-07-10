import 'package:flutter/material.dart';
import 'package:recommendation_system/data/recommendation_repository.dart';
import 'package:recommendation_system/ui/widgets/product_simply_card.dart';
import 'package:recommendation_system/ui/widgets/product_small_card.dart';

import '../../data/app_styles.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:auto_animated/auto_animated.dart';

import '../../data/product_model.dart';
import '../widgets/banner_viewer.dart';
import '../widgets/product_card.dart';

class ShopPage extends StatefulWidget {
  final String shopName;

  const ShopPage({
    Key? key,
    required this.shopName,
  }) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final LiveOptions options = const LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 35),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.025,
    reAnimateOnVisibility: false,
  );

  late var recommendedProducts = [];
  late var topProducts = [];
  late double itemWidth;

  @override
  void initState() {
    loadShopRecommendation();
    loadShopInformation();
    super.initState();
  }

  loadShopRecommendation() async {
    recommendedProducts = await RecommendationRepository.getRecommendationsInShop(widget.shopName, 2217) ?? [];
    setState(() {});
  }

  loadShopInformation() async {
    topProducts = await RecommendationRepository.getRecommendations() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    itemWidth = (MediaQuery.of(context).size.width - 3 * 16) / 2;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.headlineText,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            shopCard,
            shopStocks,
            const SizedBox(height: 24),
            recommendedProductsWidget,
            topProductsWidget,
          ],
        ),
      ),
    );
  }

  Widget get shopStocks => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 0),
            child: Text(
              "Акции магазина",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 162,
            child: BannerViwer(),
          ),
        ],
      );

  Widget get shopCard => Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        height: 96,
        child: Row(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: AppImages.shopImage(widget.shopName),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shopName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w900,
                    color: AppColors.headlineText,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Магазин продуктов и\nчего то еще",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    color: AppColors.disabledtext,
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      );

  Widget get recommendedProductsWidget => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text(
              'Рекомендуемые товары',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 132 + 74 + 40,
            child: AnimationLimiter(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: recommendedProducts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50,
                      child: FadeInAnimation(
                        child: ProductSimplyCard(
                          product: recommendedProducts[index],
                          width: 132,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
              ),
            ),
          ),
        ],
      );

  Widget get topProductsWidget => SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "Популярные товары",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.headlineText,
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
              itemCount: topProducts.length,
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
                        name: topProducts[index].name,
                        price: topProducts[index].price,
                        merchant: topProducts[index].merchant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
}
