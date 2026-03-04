import 'package:flutter/material.dart';
import '../../core/services/buyer_api_service.dart';

class FarmerListScreen extends StatefulWidget {
  final String token;

  const FarmerListScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<FarmerListScreen> createState() => _FarmerListScreenState();
}

class _FarmerListScreenState extends State<FarmerListScreen> {
  List<dynamic> _farmers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchFarmers();
  }

  Future<void> _fetchFarmers() async {
    try {
      final data = await BuyerApiService.getAllFarmers(widget.token);

      setState(() {
        _farmers = data ?? [];
        _loading = false;
      });
    } catch (e) {
      print("Erreur fetch farmers: $e");
      setState(() {
        _farmers = [];
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agriculteurs"),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _farmers.isEmpty
              ? const Center(child: Text("Aucun agriculteur trouvé"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _farmers.length,
                  itemBuilder: (_, index) {
                    final farmer = _farmers[index];

                    final username = farmer['username'] ?? "Agriculteur";
                    final email = farmer['email'] ?? "";

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(email),
                      ),
                    );
                  },
                ),
    );
  }
}