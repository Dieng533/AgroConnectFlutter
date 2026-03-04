import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../core/services/api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'buyer'; // role par défaut

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                "Créez votre compte",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Nom
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer votre nom" : null,
              ),
              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer votre email" : null,
              ),
              const SizedBox(height: 15),

              // Mot de passe
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer votre mot de passe" : null,
              ),
              const SizedBox(height: 20),

              // Selection du role
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: const [
                  DropdownMenuItem(value: 'buyer', child: Text('Acheteur')),
                  DropdownMenuItem(value: 'seller', child: Text('Vendeur')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Type de compte",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 25),

              // Bouton S'inscrire
              CustomButton(
                label: 'S’inscrire',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await ApiService.register(
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                      selectedRole, // on envoie le role
                    );

                    if (response.containsKey("error")) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response["error"])),
                      );
                    } else {
                      if (response.containsKey("conseil")) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response["conseil"])),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Compte créé avec succès")),
                        );
                      }

                      // Redirection selon le rôle
                      if (selectedRole == 'buyer') {
                        Navigator.pushReplacementNamed(
                            context, '/buyerDashboard');
                      } else if (selectedRole == 'seller') {
                        Navigator.pushReplacementNamed(
                            context, '/sellerDashboard');
                      } else if (selectedRole == 'admin') {
                        Navigator.pushReplacementNamed(
                            context, '/adminDashboard');
                      }
                    }
                  }
                },
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous avez déjà un compte ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Connectez-vous",
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}