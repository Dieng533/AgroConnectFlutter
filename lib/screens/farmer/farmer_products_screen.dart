import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../data/fake_products.dart';
import '../../widgets/product_card.dart';
import '../../widgets/dashboard_appbar.dart';

import '../../widgets/product_search_filter.dart';

class FarmerProductsScreen extends StatefulWidget {
  const FarmerProductsScreen({super.key});

  @override
  State<FarmerProductsScreen> createState() => _FarmerProductsScreenState();
}

class _FarmerProductsScreenState extends State<FarmerProductsScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  // Filtrage
  String searchQuery = '';
  String selectedCategory = 'Tous';

  @override
  void initState() {
    super.initState();
    // Charger les produits fake dans data
    products = FakeProducts.farmerProducts;
    filteredProducts = List.from(products);
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = products.where((product) {
        final matchesCategory =
            selectedCategory == 'Tous' || product.category == selectedCategory;
        final matchesSearch = product.name
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),

      // Background décoratif
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundFarme.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              // ===== Recherche + filtre =====
              ProductSearchFilter(
                selectedCategory: selectedCategory,
                onSearchChanged: (query) {
                  searchQuery = query;
                  _filterProducts();
                },
                onCategoryChanged: (category) {
                  selectedCategory = category;
                  _filterProducts();
                },
              ),

              const SizedBox(height: 8),

              // ===== Liste des produits =====
              Expanded(
                child: filteredProducts.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: filteredProducts[index],
                            onTap: () {
                              _showActions(context, filteredProducts[index]);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= EMPTY STATE =================
  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            'Aucun produit publié',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ================= ACTIONS =================
  void _showActions(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Modifier'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

