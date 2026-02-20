import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactFarmerWidget extends StatelessWidget {
  final String phoneNumber;

  const ContactFarmerWidget({super.key, required this.phoneNumber});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Impossible d’ouvrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.phone),
          label: const Text('Appeler l’agriculteur'),
          onPressed: () {
            _launchUrl('tel:$phoneNumber');
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.message),
          label: const Text('WhatsApp'),
          onPressed: () {
            _launchUrl('https://wa.me/$phoneNumber');
          },
        ),
      ],
    );
  }
}
