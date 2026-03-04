import 'package:AgroConnect/models/cart_item.dart';
import 'package:AgroConnect/models/product.dart';
import 'package:flutter/material.dart';
import '../../core/services/buyer_api_service.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String token;

  const ProductListScreen({super.key, required this.token});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  List<CartItem> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // 🔹 Charger produits depuis backend
  Future<void> fetchProducts() async {
    final result =
        await BuyerApiService.getAllProducts(widget.token);

    if (result != null) {
      setState(() {
        products = result;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 🔹 Ajouter au panier local
  void addToCart(Product product) {
    setState(() {
      final index =
          cartItems.indexWhere((item) => item.product.id == product.id);

      if (index >= 0) {
        cartItems[index].quantity += 1;
      } else {
        cartItems.add(
          CartItem(product: product, quantity: 1),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} ajouté au panier")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Produits"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(
                        token: widget.token,
                        cartItems: cartItems,
                      ),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(child: Text("Aucun produit disponible"))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 3,
                      child: ListTile(
                        leading: product.image != null &&
                                product.image!.isNotEmpty
                            ? Image.network(
                                product.image!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image, size: 40),

                        title: Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),

                        subtitle:
                            Text("${product.price} FCFA"),

                        trailing: ElevatedButton(
                          onPressed: () => addToCart(product),
                          child: const Text("Ajouter"),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}