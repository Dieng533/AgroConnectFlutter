import 'package:flutter/material.dart';
import '../farmer/dashboard_farmer.dart';
import '../buyer/dashboard_buyer.dart';
import '../../widgets/custom_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Utilisateurs simulés vue que j'ai pas de back-end
  // j'ai du simuler un faux compte pour agricuter et les acheteur 
  //veiller utiliser ces info pour tester
  final List<Map<String, String>> users = [
    {"email": "farmer@test.com", "password": "123456", "role": "FARMER"},
    {"email": "buyer@test.com", "password": "123456", "role": "BUYER"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // IMAGE DE FOND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/farm.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // DÉGRADÉ VERT → ORANGE (avec correction de la dépréciation)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.withAlpha((0.7 * 255).toInt()),
                  Colors.orange.withAlpha((0.7 * 255).toInt()),
                ],
              ),
            ),
          ),

          // CONTENU
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white.withOpacity(0.85),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.agriculture,
                        size: 70,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // EMAIL
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // PASSWORD
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon: const Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // BOUTON SE CONNECTER
                      CustomButton(
                        label: 'Se connecter',
                        onPressed: _login,
                      ),

                      const SizedBox(height: 15),

                      // BOUTON INSCRIPTION
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Pas encore de compte ? Inscription',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    Map<String, String>? user;

    // Recherche de l'utilisateur
    for (var u in users) {
      if (u["email"] == email && u["password"] == password) {
        user = u;
        break;
      }
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou mot de passe incorrect')),
      );
      return;
    }

    // Navigation selon le rôle
    if (user["role"] == "FARMER") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardFarmer()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  DashboardBuyer()),
      );
    }
  }
}

