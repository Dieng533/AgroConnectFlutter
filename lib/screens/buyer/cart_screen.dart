import 'package:AgroConnect/models/cart_item.dart';
import 'package:flutter/material.dart';
import '../../core/services/buyer_api_service.dart';

class CartScreen extends StatefulWidget {
  final String token;
  final List<CartItem> cartItems;

  const CartScreen({
    super.key,
    required this.token,
    required this.cartItems,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> cartItems;
  bool isOrdering = false;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
  }

  // 🔹 Calcul automatique total
  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  // 🔹 Augmenter quantité
  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  // 🔹 Diminuer quantité
  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  // 🔹 Supprimer produit
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // 🔹 Créer commande
  Future<void> checkout() async {
    if (cartItems.isEmpty) return;

    setState(() => isOrdering = true);

    bool success =
        await BuyerApiService.createOrder(widget.token, cartItems);

    setState(() => isOrdering = false);

    if (success) {
      setState(() {
        cartItems.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Commande créée avec succès ✅"),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erreur lors de la commande ❌"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Panier"),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Votre panier est vide",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),

                              Text(
                                  "Prix: ${item.product.price} FCFA"),

                              const SizedBox(height: 10),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            decreaseQuantity(index),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style:
                                            const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            increaseQuantity(index),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        removeItem(index),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 🔹 Section total + bouton commander
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total :",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "$totalPrice FCFA",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              isOrdering ? null : checkout,
                          child: isOrdering
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text("Commander"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}