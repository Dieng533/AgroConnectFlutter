import 'package:flutter/material.dart';

class CultureCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int hectares;
  final int productionPercent;

  const CultureCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.hectares,
    required this.productionPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Hectares: $hectares ha',
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text('Production: $productionPercent%',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
