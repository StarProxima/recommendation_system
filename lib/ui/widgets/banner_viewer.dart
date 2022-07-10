import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recommendation_system/ui/widgets/stock_banner.dart';

import 'package:recommendation_system/ui/pages/stock_page.dart';

class BannerViwer extends StatelessWidget {
  const BannerViwer({Key? key}) : super(key: key);

  final List<Widget> banners = const [
    StockBanner(image: AssetImage('assets/banner1.png')),
    StockBanner(image: AssetImage('assets/banner2.png')),
    StockBanner(image: AssetImage('assets/banner3.png')),
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        initialPage: 500,
        viewportFraction: 0.85,
      ),
      itemBuilder: (BuildContext context, int index) {
        return banners[index % 3];
      },
    );
  }
}

class StockBanner extends StatelessWidget {
  const StockBanner({Key? key, required this.image}) : super(key: key);

  final AssetImage image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return StockPage();
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
