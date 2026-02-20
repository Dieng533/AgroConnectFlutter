import 'package:flutter/material.dart';

class ProductSearchFilter extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onCategoryChanged;
  final String selectedCategory;

  const ProductSearchFilter({
    super.key,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🔍 RECHERCHE
          TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher un produit...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onSearchChanged,
          ),

          const SizedBox(height: 10),

          // 🧩 FILTRE
          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'Tous', child: Text('Toutes catégories')),
              DropdownMenuItem(value: 'Légumes', child: Text('Légumes')),
              DropdownMenuItem(value: 'Céréales', child: Text('Céréales')),
            ],
            onChanged: (value) {
              if (value != null) {
                onCategoryChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
