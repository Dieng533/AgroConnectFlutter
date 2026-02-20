import 'package:flutter/material.dart';
import '/widgets/dashboard_background.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Stack(
        children: [
          const DashboardBackground(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nom: ${product.name}', style: const TextStyle(fontSize: 18)),
                Text('Prix: ${product.price} €', style: const TextStyle(fontSize: 18)),
                Text('Catégorie: ${product.category}', style: const TextStyle(fontSize: 18)),
                Text('Localisation: ${product.location}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Contacter l’agriculteur'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//pour rapeler aussi que les donner ne sont que temporaire normal sa vient du back-end