import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_background.dart';

class AddCultureScreen extends StatefulWidget {
  const AddCultureScreen({super.key});

  @override
  State<AddCultureScreen> createState() => _AddCultureScreenState();
}

class _AddCultureScreenState extends State<AddCultureScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _addCulture() {
    final name = nameController.text.trim();
    final desc = descController.text.trim();

    if (name.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Culture ajoutée avec succès')),
    );

    nameController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                'Ajouter une culture',
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
                  labelText: 'Nom de la culture',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              CustomButton(label: 'Ajouter', onPressed: _addCulture),
            ],
          ),
        ),
      ),
    );
  }
}
