import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../screens/farmer/add_culture_screen.dart';
import '../../screens/farmer/add_product_screen.dart';
import '../../screens/farmer/farmer_products_screen.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          label: 'Ajouter une culture',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddCultureScreen()),
            );
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          label: 'Ajouter un produit',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddProductScreen()),
            );
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          label: 'Voir mes produits',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FarmerProductsScreen()),
            );
          },
        ),
      ],
    );
  }
}
