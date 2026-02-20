import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_background.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _addProduct() {
    final name = nameController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0;
    final category = categoryController.text.trim();
    final location = locationController.text.trim();

    if (name.isEmpty || price <= 0 || category.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs correctement')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produit ajouté avec succès')),
    );

    nameController.clear();
    priceController.clear();
    categoryController.clear();
    locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Back Button =====
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),

            const Text(
              'Ajouter un produit',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // ===== Formulaire =====
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nom du produit',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Prix',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Catégorie',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Localisation',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            CustomButton(label: 'Ajouter', onPressed: _addProduct),
          ],
        ),
      ),
    );
  }
}
