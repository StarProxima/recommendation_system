import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/ui/pages/stock_page.dart';

class StockBanner extends StatelessWidget {
  const StockBanner({Key? key, required this.image}) : super(key: key);

  final AssetImage image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openStockPage(context);
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

  void openStockPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StockPage();
        },
      ),
    );
  }
}
