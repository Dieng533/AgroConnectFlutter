import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import 'product_list_screen.dart';
import 'cart_screen.dart';
import 'farmer_list_screen.dart';
import '/widgets/dashboard_background.dart';
import '../../core/widgets_buyer/dashboard_action_card.dart';

class DashboardBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord Acheteur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
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
      // dans le body j'appelle des widgets car ce projet est decomposer
      //en petit morcer de code afin de pas saturer noublier pas de regarder core-widgets buyer ou widgets
      body: Stack(
        children: [
          const DashboardBackground(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 40),

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
                          builder: (_) => ProductListScreen()),
                    );
                  },
                ),

                const SizedBox(height: 20),

                DashboardActionCard(
                  icon: Icons.agriculture,
                  title: 'Trouver des agriculteurs',
                  subtitle:
                      'Découvrez les agriculteurs,ONG, ou groupement, leurs champs et Activite de productions',
                  buttonText: 'Voir les agriculteurs',
                  //condition du bouton et navigation,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FarmerListScreen()),
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


