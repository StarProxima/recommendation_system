import 'package:flutter/material.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/ui/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "Рекомендуем",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
                left: 16,
                right: 16,
              ),
              itemCount: 20,
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.633,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: Product(
                    name:
                        'name ${index * index * index * index * index * index * index * index * index}',
                    price: 20.0 * index * index,
                    merchant: 'ООО "ОВОЩЕБАЗА"',
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Специально для вас",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
                left: 16,
                right: 16,
              ),
              itemCount: 20,
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.633,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: Product(
                    name:
                        'name ${index * index * index * index * index * index * index * index * index}',
                    price: 20.0 * index * index,
                    merchant: 'Девяточка',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
