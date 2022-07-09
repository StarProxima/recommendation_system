import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/ui/pages/product_page.dart';

class ProductConnectedCard extends StatefulWidget {
  const ProductConnectedCard({
    Key? key,
    required this.product,
    required this.width,
    this.buyButton = false,
  }) : super(key: key);

  final Product product;
  final double width;
  final bool buyButton;
  @override
  State<ProductConnectedCard> createState() => _ProductConnectedCardState();
}

class _ProductConnectedCardState extends State<ProductConnectedCard> {
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
                    width: widget.width,
                    height: widget.width,
                    child: const Image(
                      color: AppColors.disabled,
                      image: AppImages.cart,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
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
                  const SizedBox(height: 4),
                  widget.buyButton
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: BottomProductBuyButton(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            widget.product.merchant,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
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
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.headlineText,
              borderRadius: BorderRadius.circular(14),
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
                  height: 28,
                  width: 28,
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
                  height: 28,
                  width: 28,
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
