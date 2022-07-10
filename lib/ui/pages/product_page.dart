import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/data/recommendation_repository.dart';
import 'package:recommendation_system/ui/pages/shop_page.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:recommendation_system/ui/widgets/product_small_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int amount = 0;

  bool togetherPurchases = false;
  List<Product> similarProducts = [];
  List<Product> connectedProducts = [];

  Future<void> getRecs() async {
    similarProducts =
        await RecommendationRepository.getSimilarProducts(widget.product) ?? [];
    connectedProducts =
        await RecommendationRepository.getConnectedProducts(widget.product) ??
            [];
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getRecs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: width / 1.25,
                padding: const EdgeInsets.all(0),
                child: Image(
                  image: AppImages.productImage(widget.product.name),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextButton(
                      onPressed: () {
                        openShopPage();
                      },
                      child: Text(
                        widget.product.merchant,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: amount == 0 ? AppColors.headlineText : null,
                    ),
                    height: 50,
                    width: double.infinity,
                    child: amount == 0
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                amount = 1;
                                togetherPurchases = true;
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
                                '${widget.product.price.toInt()}₽   •   Купить',
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.product.price.toInt() * amount}₽",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    '${widget.product.price.toInt()}₽ x $amount шт',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  FloatingActionButton(
                                    elevation: 0,
                                    onPressed: () {
                                      setState(() {
                                        amount--;
                                      });
                                    },
                                    backgroundColor: AppColors.headlineText,
                                    heroTag: null,
                                    child: const Icon(Icons.remove),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        '$amount шт',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                  ),
                                  FloatingActionButton(
                                    elevation: 0,
                                    onPressed: () {
                                      setState(() {
                                        amount++;
                                      });
                                    },
                                    backgroundColor: AppColors.headlineText,
                                    heroTag: null,
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              togetherPurchases
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Покупают вместе: ',
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 275,
                          child: AnimationLimiter(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              scrollDirection: Axis.horizontal,
                              itemCount: connectedProducts.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: ProductSmallCard(
                                        product: connectedProducts[index],
                                        width: 135,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Похожие товары: ',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
              ),
              AnimationLimiter(
                key: ValueKey(similarProducts.length),
                child: SizedBox(
                  height: 275,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    scrollDirection: Axis.horizontal,
                    itemCount: similarProducts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: ProductSmallCard(
                              product: similarProducts[index],
                              width: 135,
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
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: null,
    );
  }

  void openShopPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ShopPage(
            shopName: widget.product.merchant,
          );
        },
      ),
    );
  }
}
