import 'package:flutter/material.dart';

class FormBackground extends StatelessWidget {
  final Widget child;

  const FormBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Fond avec image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/dashboard_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 2. Dégradé semi-transparent
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green.withOpacity(0.7),
                Colors.orange.withOpacity(0.7),
              ],
            ),
          ),
        ),

        // 3. Contenu du formulaire
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ],
    );
  }
}
