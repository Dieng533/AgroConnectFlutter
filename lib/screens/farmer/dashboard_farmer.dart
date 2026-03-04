import 'dart:io';
import 'dart:typed_data';
import 'package:AgroConnect/screens/auth/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/farmer_api_service.dart';

class DashboardFarmer extends StatefulWidget {
  final String token;
  const DashboardFarmer({Key? key, required this.token}) : super(key: key);

  @override
  State<DashboardFarmer> createState() => _DashboardFarmerState();
}

class _DashboardFarmerState extends State<DashboardFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _products = [];
  List<dynamic> _orders = [];

  bool _loadingProducts = true;
  bool _loadingOrders = true;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  File? _pickedImage;
  Uint8List? _webImage;
  final picker = ImagePicker();

  bool _isEditing = false;
  int? _editingProductId;

  final Color primaryGreen = const Color(0xFF1B8E3E);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchProducts();
    _fetchOrders();
  }

  // ================= FETCH =================
  Future<void> _fetchProducts() async {
    setState(() => _loadingProducts = true);
    final products = await FarmerApiService.getFarmerProducts(widget.token);
    setState(() {
      _products = products ?? [];
      _loadingProducts = false;
    });
  }

  Future<void> _fetchOrders() async {
    setState(() => _loadingOrders = true);
    final orders = await FarmerApiService.getFarmerOrders(widget.token);
    setState(() {
      _orders = orders ?? [];
      _loadingOrders = false;
    });
  }

  // ================= IMAGE =================
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        _webImage = await pickedFile.readAsBytes();
      } else {
        _pickedImage = File(pickedFile.path);
      }
      setState(() {});
    }
  }

  // ================= CREATE / UPDATE PRODUIT =================
  Future<void> _saveProduct() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty) return;

    bool success;

    if (_isEditing) {
      success = await FarmerApiService.updateProduct(
        widget.token,
        _editingProductId!,
        _nameController.text,
        _descriptionController.text,
        double.parse(_priceController.text),
        int.parse(_quantityController.text),
        _pickedImage,
        _webImage,
      );
    } else {
      success = await FarmerApiService.createProduct(
        widget.token,
        _nameController.text,
        _descriptionController.text,
        double.parse(_priceController.text),
        int.parse(_quantityController.text),
        _pickedImage,
        _webImage,
      );
    }

    if (success) {
      Navigator.pop(context);
      _clearForm();
      _fetchProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryGreen,
          content: Text(_isEditing ? "Produit modifié" : "Produit ajouté"),
        ),
      );
    }
  }

  // ================= DELETE PRODUIT =================
  Future<void> _deleteProduct(int id) async {
    bool success = await FarmerApiService.deleteProduct(widget.token, id);

    if (success) {
      _fetchProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Produit supprimé"),
        ),
      );
    }
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _quantityController.clear();
    _pickedImage = null;
    _webImage = null;
    _isEditing = false;
    _editingProductId = null;
  }

  // ================= CREATE COMMANDE =================
  Future<void> _createOrder(int productId) async {
    bool success = await FarmerApiService.createOrder(widget.token, [
      {"product_id": productId, "quantity": 1} // 1 produit à la fois
    ]);

    if (success) {
      await _fetchOrders();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Commande envoyée !")),
      );
    }
  }

  // ================= MODAL PRODUIT =================
  void _showProductModal({dynamic product}) {
    if (product != null) {
      _isEditing = true;
      _editingProductId = product['id'];
      _nameController.text = product['name'];
      _descriptionController.text = product['description'] ?? '';
      _priceController.text = product['price'].toString();
      _quantityController.text = product['quantity'].toString();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  _isEditing ? "Modifier Produit" : "Ajouter Produit",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                _buildInput(_nameController, "Nom"),
                _buildInput(_descriptionController, "Description"),
                _buildInput(_priceController, "Prix", type: TextInputType.number),
                _buildInput(_quantityController, "Quantité", type: TextInputType.number),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: primaryGreen),
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Choisir image"),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _saveProduct,
                  child: Text(_isEditing ? "Modifier" : "Ajouter"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInput(TextEditingController controller, String label,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  // ================= LOGOUT =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Dashboard Farmer"),
        actions: [
           IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.store), text: "Produits"),
            Tab(icon: Icon(Icons.receipt), text: "Commandes"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProducts(),
          _buildOrders(),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              backgroundColor: primaryGreen,
              onPressed: () => _showProductModal(),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildProducts() {
    if (_loadingProducts) return const Center(child: CircularProgressIndicator());
    if (_products.isEmpty) return const Center(child: Text("Aucun produit"));

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: _products.length,
      itemBuilder: (_, index) {
        final prod = _products[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            title: Text(prod['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Prix: ${prod['price']} | Stock: ${prod['quantity']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _showProductModal(product: prod)),
                IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(prod['id'])),
                IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.green),
                    onPressed: () => _createOrder(prod['id'])),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrders() {
    if (_loadingOrders) return const Center(child: CircularProgressIndicator());
    if (_orders.isEmpty) return const Center(child: Text("Aucune commande"));

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: _orders.length,
      itemBuilder: (_, index) {
        final order = _orders[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            title: Text("Commande #${order['id']}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Produit: ${order['product_name']}"),
                Text("Quantité: ${order['quantity']}"),
                Text("Prix unitaire: ${order['product_price']} FCFA"),
                Text("Total: ${order['total']} FCFA"),
                Text("Acheteur: ${order['buyer']}"),
                Text("Status: ${order['status']}"),
              ],
            ),
          ),
        );
      },
    );
  }
}