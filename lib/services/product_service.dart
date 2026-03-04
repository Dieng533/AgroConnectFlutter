// lib/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Récupérer la liste des produits avec filtrage
  static Future<List<Product>> fetchProducts({String? category, String? search, String? ordering}) async {
    String url = '$baseUrl/products/?';

    if (category != null) url += 'category=$category&';
    if (search != null) url += 'search=$search&';
    if (ordering != null) url += 'ordering=$ordering&';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
