import 'package:flutter/material.dart';

import 'culture_card.dart';

class CultureCarousel extends StatelessWidget {
  const CultureCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView(
        controller: PageController(viewportFraction: 0.8),
        children: const [
          CultureCard(
              name: 'Arachides', imagePath: 'assets/images/Arachides.jpg', hectares: 12, productionPercent: 80),
          CultureCard(
              name: 'Tomate', imagePath: 'assets/images/tomates.jpg', hectares: 8, productionPercent: 60),
          CultureCard(
              name: 'Riz', imagePath: 'assets/images/riz.jpg', hectares: 5, productionPercent: 90),
        ],
      ),
    );
  }
}
