import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nom')),
            SizedBox(height: 10),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Mot de passe'), obscureText: true),
            SizedBox(height: 20),
            CustomButton(
              label: 'S’inscrire',
              onPressed: () {
                // Pour simulation, on redirige juste vers login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

