import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import 'product_list_screen.dart';
import 'cart_screen.dart';
import 'farmer_list_screen.dart';
import '/widgets/dashboard_background.dart';
import '../../core/widgets_buyer/dashboard_action_card.dart';

class DashboardBuyer extends StatelessWidget {
  final String token;

  const DashboardBuyer({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord Acheteur'),
        actions: [
          // 🛒 PANIER
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(token: token, cartItems: [],),
                ),
              );
            },
          ),

          // 🔓 LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: Stack(
        children: [
          const DashboardBackground(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 🛍 VOIR PRODUITS
                DashboardActionCard(
                  icon: Icons.shopping_basket,
                  title: 'Acheter des produits',
                  subtitle:
                      'Consultez les produits frais proposés par les agriculteurs',
                  buttonText: 'Voir les produits',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                       builder: (_) => ProductListScreen(token: token),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // 👨‍🌾 VOIR FARMERS
                DashboardActionCard(
                  icon: Icons.agriculture,
                  title: 'Trouver des agriculteurs',
                  subtitle:
                      'Découvrez les agriculteurs, ONG ou groupements',
                  buttonText: 'Voir les agriculteurs',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FarmerListScreen(token: token),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}