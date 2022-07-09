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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 36,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${widget.product.price.toInt()} ₽",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        widget.buyButton
                            ? const BottomProductBuyButton()
                            : Text(
                                widget.product.merchant,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                        const SizedBox(
                          height: 8,
                        ),
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
        : Row(
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
          );
  }
}
