import 'package:flutter/material.dart';
import '/widgets/dashboard_background.dart';

class FarmerListScreen extends StatelessWidget {
  const FarmerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agriculteurs & Champs')),
      body: Stack(
        children: [
          //  Fond avec dégradé
          const DashboardBackground(),

          //  Liste des agriculteurs rapeller aussi que c'est juste pour simuler
          // mais normalement sa doit etre la liste des agriculteur inscrite dans la base de donner 
          ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              FarmerTile(
                name: 'Sofie Traore',
                village: 'Wallo',
                phone: '77 000 00 00',
                crop: 'Riz',
              ),
              FarmerTile(
                name: 'Traoré Moussa',
                village: 'Kebemere',
                phone: '77 000 00 00',
                crop: 'Maïs',
              ),
              FarmerTile(
                name: 'ISRA',
                village: 'Saint-Louis',
                phone: '77 000 00 00',
                crop: 'Evoluation et recherche',
              ),
               FarmerTile(
                name: 'FONGS',
                village: 'Tamba',
                phone: '77 000 00 00',
                crop: 'Accompagement Entrepreneur agronome',
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}

class FarmerTile extends StatelessWidget {
  final String name;
  final String village;
  final String phone;
  final String crop;

  const FarmerTile({
    super.key,
    required this.name,
    required this.village,
    required this.phone,
    required this.crop,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.85), 
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.green),
        title: Text(name),
        subtitle: Text('$crop • $village'),
        trailing: const Icon(Icons.call),
        onTap: () {
          // Plus tard : appeler ou voir détail
        },
      ),
    );
  }
}
