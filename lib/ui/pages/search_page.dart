import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:recommendation_system/data/recommendation_repository.dart';
import 'package:recommendation_system/ui/widgets/product_card.dart';
import 'package:auto_animated/auto_animated.dart';

import '../../data/product_model.dart';
import '../widgets/search_panel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.controller,
    this.shop,
  }) : super(key: key);

  final TextEditingController controller;
  final String? shop;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final LiveOptions options = const LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 35),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.025,
    reAnimateOnVisibility: false,
  );

  List<Product> searchedProducts = [];

  String? lastQuery;

  bool isLoad = false;

  FocusNode searchPanelFocus = FocusNode();

  void getSearchProducts() async {
    searchPanelFocus.unfocus();
    if (widget.controller.text != lastQuery) {
      if (lastQuery != null) FocusScope.of(context).unfocus();

      searchedProducts = await RecommendationRepository.getProducts(widget.controller.text) ?? [];

      lastQuery = widget.controller.text;
      if (mounted) setState(() {});
    }
  }

  void getRec() async {
    searchedProducts = await RecommendationRepository.getRecommendations() ?? [];
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (MediaQuery.of(context).size.width - 3 * 16) / 2;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 12,
              right: 12,
            ),
            child: SearchPanel(
              focus: searchPanelFocus,
              controller: widget.controller,
              backButton: true,
              onEditingComplete: () async {
                log('onEditingComplete');
                getSearchProducts();
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        key: ValueKey(lastQuery),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                lastQuery == null
                    ? ''
                    : lastQuery!.isNotEmpty
                        ? "Вот, что удалось найти по запросу '$lastQuery':"
                        : "Пожалуйста, введите запрос для поиска",
                style: Theme.of(context).textTheme.headlineMedium,
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
              itemCount: searchedProducts.length,
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
                        name: searchedProducts[index].name,
                        price: searchedProducts[index].price,
                        merchant: searchedProducts[index].merchant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
