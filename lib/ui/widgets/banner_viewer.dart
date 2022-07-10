import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:recommendation_system/ui/widgets/stock_banner.dart';

class BannerViwer extends StatelessWidget {
  BannerViwer({Key? key}) : super(key: key);

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
