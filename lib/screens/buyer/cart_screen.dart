import 'package:flutter/material.dart';
import '/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Mon panier')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Panier vide'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle:
                            Text('Qté: ${item.quantity}'),
                        trailing:
                            Text('${item.totalPrice} FCFA'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total: ${CartService.total} FCFA',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        child: const Text('Commander'),
                        onPressed: () {
                          CartService.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Commande envoyée')),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
