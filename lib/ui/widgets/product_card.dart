import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/ui/pages/product_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.width,
    this.buyButton = false,
  }) : super(key: key);

  final Product product;
  final double width;
  final bool buyButton;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double get padd => widget.width < 140 ? 8 : 12;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.width,
          maxHeight: widget.width + 114,
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
                    child: const Image(
                      image: AppImages.cart,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: padd, right: padd, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 24,
                          padding: EdgeInsets.symmetric(
                              horizontal: padd, vertical: 3),
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${widget.product.price.toInt()} ₽",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // const SizedBox(
                        //   height: 8,
                        // ),
                      ],
                    ),
                  ),
                  widget.buyButton
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: padd),
                          child: const BottomProductBuyButton(),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: padd),
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
