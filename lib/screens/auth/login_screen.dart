import 'package:flutter/material.dart';
import '../farmer/dashboard_farmer.dart';
import '../buyer/dashboard_buyer.dart';
import '../../widgets/custom_button.dart';
import '../../core/services/api_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

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

          // DÉGRADÉ
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

                      // BOUTON
                      isLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              label: 'Se connecter',
                              onPressed: _login,
                            ),

                      const SizedBox(height: 15),

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

  // ==========================
  // LOGIN BACKEND
  // ==========================
  void _login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Veuillez remplir tous les champs")),
    );
    return;
  }

  setState(() => isLoading = true);

  final response = await ApiService.login(email, password);

  if (response.containsKey("access")) {
    String token = response["access"];

    final profile = await ApiService.getProfile(token);

    if (profile.containsKey("error")) {
      showError(profile["error"]);
    } else {
      String role = profile["role"].toString().toLowerCase(); // minuscule pour uniformité
      print("ROLE CONNECTÉ : $role");

      // Redirection selon rôle
      if (role == "farmer" || role == "seller") {
        // backend renvoie seller → on considère comme farmer
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardFarmer(token: token)),
        );
      } else if (role == "buyer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardBuyer(token: token,)),
        );
      } else {
        showError("Rôle inconnu : $role");
      }
    }
  } else if (response.containsKey("error")) {
    showError(response["error"]);
  } else {
    showError("Email ou mot de passe incorrect");
  }

  setState(() => isLoading = false);
}

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}