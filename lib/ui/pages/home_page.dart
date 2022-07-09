import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/ui/widgets/product_card.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:http/http.dart' as http;

import '../../data/product_model.dart';
import '../widgets/search_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LiveOptions options = const LiveOptions(
    delay: Duration(milliseconds: 0),
    showItemInterval: Duration(milliseconds: 35),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.025,
    reAnimateOnVisibility: false,
  );

  late List<Product> recomendedProducts = [];

  void loadRecomendation() async {
    var url = Uri(
      scheme: "http",
      host: Platform.isAndroid ? '10.0.2.2' : '127.0.0.1',
      path: "/recomend",
      port: 5000,
    );
    print(url.normalizePath());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      //var itemCount = jsonResponse['totalItems'];
      setState(() {
        recomendedProducts.clear();
        for (var product in jsonResponse) {
          recomendedProducts.add(Product.fromJson(product));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    loadRecomendation();
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (MediaQuery.of(context).size.width - 3 * 16) / 2;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 12,
              right: 12,
            ),
            child: SearchPanel(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "Рекомендуем",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Специально для вас",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            // GridView.builder(
            //   padding: const EdgeInsets.only(
            //     top: 20,
            //     bottom: 40,
            //     left: 16,
            //     right: 16,
            //   ),
            //   itemCount: 20,
            //   primary: false,
            //   shrinkWrap: true,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: 0.633,
            //     mainAxisSpacing: 16,
            //     crossAxisSpacing: 16,
            //   ),
            //   itemBuilder: (context, index) {
            //     return ProductCard(
            //       product: Product(
            //         name:
            //             'name ${index * index * index * index * index * index * index * index * index}',
            //         price: 20.0 * index * index,
            //         merchant: 'Девяточка',
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
