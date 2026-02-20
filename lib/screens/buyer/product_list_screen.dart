import 'package:flutter/material.dart';
import '/widgets/dashboard_background.dart';
import '../../data/fake_products.dart';
import '../../core/widgets_buyer/product_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produits disponibles')),
      body: Stack(
        children: [
          const DashboardBackground(), 
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: FakeProducts.farmerProducts.length,
            itemBuilder: (context, index) {
              final product = FakeProducts.farmerProducts[index]; // j'ai simuler des produit dans data
              return ProductCard(
                product: product,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
