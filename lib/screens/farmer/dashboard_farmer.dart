import 'package:flutter/material.dart';
import '../../widgets/farmer_app_bar.dart';
import '../../widgets/dashboard_background.dart';
import '../../widgets/weather_card.dart';
import '../../widgets/culture_carousel.dart';
import '../../widgets/dashboard_buttons.dart';

class DashboardFarmer extends StatelessWidget {
  const DashboardFarmer({super.key});
// Noublie pas de regarder les importation pour comprendre les widgets importer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: Stack(
        children: [
          const DashboardBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const WeatherCard(),
                  const SizedBox(height: 20),
                  const CultureCarousel(),
                  const SizedBox(height: 20),
                  DashboardButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

