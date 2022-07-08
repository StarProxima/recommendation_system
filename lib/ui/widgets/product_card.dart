import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              primary: AppColors.disabledtext,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
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
                  Text(
                    widget.product.merchant,
                    style: Theme.of(context).textTheme.labelSmall,
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
