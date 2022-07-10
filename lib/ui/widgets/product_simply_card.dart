import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/ui/pages/product_page.dart';

class ProductSimplyCard extends StatefulWidget {
  const ProductSimplyCard({
    Key? key,
    required this.product,
    required this.width,
  }) : super(key: key);

  final Product product;
  final double width;
  @override
  State<ProductSimplyCard> createState() => _ProductSimplyCardState();
}

class _ProductSimplyCardState extends State<ProductSimplyCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.width,
          maxHeight: widget.width + 82,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.divider,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
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
                    width: widget.width - 2,
                    height: widget.width - 2,
                    child: const Image(
                      image: AppImages.cart,
                      color: AppColors.disabled,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    height: 30,
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
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.product.price.toInt()}₽",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.cashback,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          height: 24,
                          child: Text(
                            "+${(widget.product.price * 0.2).toInt()}₽",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
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
                    onPressed: () {
                      setState(() {
                        amount--;
                      });
                    },
                    backgroundColor: AppColors.headlineText,
                    heroTag: null,
                    child: const Icon(Icons.remove),
                  ),
                ),
                Center(
                  child: Text(
                    '$amount шт',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        amount++;
                      });
                    },
                    backgroundColor: AppColors.headlineText,
                    heroTag: null,
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );
  }
}
