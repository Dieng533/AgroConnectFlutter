import 'dart:convert';
import 'package:AgroConnect/models/cart_item.dart';
import 'package:AgroConnect/models/order.dart';
import 'package:AgroConnect/models/product.dart';
import 'package:http/http.dart' as http;

class BuyerApiService {
  static const String baseUrl = "https://agroconnect-backend-api.onrender.com/api";
 // static const String baseUrl = "http://127.0.0.1:8000/api";

  // ===============================
  // Récupérer tous les produits
  // ===============================
  static Future<List<Product>?> getAllProducts(String token) async {
    final uri = Uri.parse('$baseUrl/products/');
    try {
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        print("Erreur getAllProducts: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception getAllProducts: $e");
      return null;
    }
  }

  // ===============================
  // Récupérer tous les farmers
  // ===============================
  static Future<List<dynamic>?> getAllFarmers(String token) async {
    final uri = Uri.parse('$baseUrl/farmers/');
    try {
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Erreur getAllFarmers: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception getAllFarmers: $e");
      return null;
    }
  }

  // ===============================
  // Créer commande depuis une liste de CartItem
  // ===============================
  static Future<bool> createOrder(String token, List<CartItem> cartItems) async {
    final uri = Uri.parse('$baseUrl/orders/'); // <-- PAS de /create/

    // Préparer le payload
    final items = cartItems
        .map((item) => {"product_id": item.product.id, "quantity": item.quantity})
        .toList();

    try {
      // Si ton serializer gère une commande par produit
      bool success = true;
      for (var item in items) {
        final response = await http.post(uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json"
            },
            body: jsonEncode(item));

        if (response.statusCode != 201 && response.statusCode != 200) {
          print("Erreur createOrder: ${response.statusCode} ${response.body}");
          success = false;
        }
      }
      return success;
    } catch (e) {
      print("Exception createOrder: $e");
      return false;
    }
  }

  // ===============================
  // Voir commandes buyer
  // ===============================
  static Future<List<Order>?> getBuyerOrders(String token) async {
    final uri = Uri.parse('$baseUrl/orders/');
    try {
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((e) => Order.fromJson(e)).toList();
      } else {
        print("Erreur getBuyerOrders: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception getBuyerOrders: $e");
      return null;
    }
  }
}