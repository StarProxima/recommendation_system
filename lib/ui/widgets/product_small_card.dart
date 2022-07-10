import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/ui/pages/product_page.dart';

class ProductSmallCard extends StatefulWidget {
  const ProductSmallCard({
    Key? key,
    required this.product,
    required this.width,
  }) : super(key: key);

  final Product product;
  final double width;

  @override
  State<ProductSmallCard> createState() => _ProductSmallCardState();
}

class _ProductSmallCardState extends State<ProductSmallCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.width,
          maxHeight: widget.width + 104,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductPage(
                        product: widget.product,
                      );
                    },
                  ),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: AppColors.disabledtext,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widget.width,
                    height: widget.width,
                    child: Image(
                      image: AppImages.productImage(widget.product.name),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 32,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 16,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.product.price.toInt()}₽",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: BottomProductBuyButton(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomProductBuyButton extends StatefulWidget {
  const BottomProductBuyButton({Key? key}) : super(key: key);

  @override
  State<BottomProductBuyButton> createState() => _BottomProductBuyButtonState();
}

class _BottomProductBuyButtonState extends State<BottomProductBuyButton> {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    return amount == 0
        ? Container(
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.headlineText,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  amount = 1;
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
              ),
              child: const Center(
                child: Text(
                  'Купить',
                ),
              ),
            ),
          )
        : Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      setState(() {
                        amount--;
                      });
                    },
                    backgroundColor: AppColors.headlineText,
                    heroTag: null,
                    child: const Icon(
                      Icons.remove,
                      size: 12,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '$amount шт',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      setState(() {
                        amount++;
                      });
                    },
                    backgroundColor: AppColors.headlineText,
                    heroTag: null,
                    child: const Icon(
                      Icons.add,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
