import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../services/cart_service.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add_shopping_cart),
      label: const Text('Ajouter au panier'),
      onPressed: product.quantity <= 0
          ? null
          : () {
              CartService.addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Produit ajouté au panier')),
              );
            },
    );
  }
}
