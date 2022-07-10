import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BannerViwer extends StatelessWidget {
  BannerViwer({Key? key}) : super(key: key);

  final List<Widget> banners = [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage('assets/banner1.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage('assets/banner2.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: AssetImage('assets/banner3.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
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
