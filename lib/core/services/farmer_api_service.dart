import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class FarmerApiService {
 // static const String baseUrl = 'http://127.0.0.1:8000/api';
 static const String baseUrl = 'https://agroconnect-backend-api.onrender.com/api';
  static String? refreshToken;

  // ===============================
  // LOGIN
  // ===============================
  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    final uri = Uri.parse('$baseUrl/token/');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('refresh')) refreshToken = data['refresh'];
      return data;
    } else {
      print("Login error: ${response.body}");
      return null;
    }
  }

  // ===============================
  // REFRESH TOKEN
  // ===============================
  static Future<String?> refreshAccessToken() async {
    if (refreshToken == null) return null;

    final uri = Uri.parse('$baseUrl/token/refresh/');
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refresh": refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access'];
    } else {
      print("Refresh error: ${response.body}");
      return null;
    }
  }

  // ===============================
  // GET PRODUITS DU FARMER
  // ===============================
  static Future<List<dynamic>?> getFarmerProducts(String accessToken) async {
    final uri = Uri.parse('$baseUrl/products/');
    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) return jsonDecode(response.body);

    if (response.statusCode == 401) {
      final newToken = await refreshAccessToken();
      if (newToken != null) return await getFarmerProducts(newToken);
    }

    print("Erreur getFarmerProducts: ${response.body}");
    return null;
  }

  // ===============================
  // GET COMMANDES DU FARMER
  // ===============================
  static Future<List<dynamic>?> getFarmerOrders(String accessToken) async {
    final uri = Uri.parse('$baseUrl/orders/');
    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) return jsonDecode(response.body);

    if (response.statusCode == 401) {
      final newToken = await refreshAccessToken();
      if (newToken != null) return await getFarmerOrders(newToken);
    }

    print("Erreur getFarmerOrders: ${response.body}");
    return null;
  }

  // ===============================
  // CREATE PRODUIT
  // ===============================
  static Future<bool> createProduct(
      String accessToken,
      String name,
      String description,
      double price,
      int quantity,
      File? imageFile,
      Uint8List? webImage) async {
    return _sendProductRequest(
      method: "POST",
      accessToken: accessToken,
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      imageFile: imageFile,
      webImage: webImage,
    );
  }

  // ===============================
  // UPDATE PRODUIT
  // ===============================
  static Future<bool> updateProduct(
      String accessToken,
      int productId,
      String name,
      String description,
      double price,
      int quantity,
      File? imageFile,
      Uint8List? webImage) async {
    return _sendProductRequest(
      method: "PUT",
      accessToken: accessToken,
      productId: productId,
      name: name,
      description: description,
      price: price,
      quantity: quantity,
      imageFile: imageFile,
      webImage: webImage,
    );
  }

  // ===============================
  // DELETE PRODUIT
  // ===============================
  static Future<bool> deleteProduct(String accessToken, int productId) async {
    final uri = Uri.parse('$baseUrl/products/$productId/');
    final response = await http.delete(uri, headers: {
      "Authorization": "Bearer $accessToken",
    });

    if (response.statusCode == 204) return true;

    if (response.statusCode == 401) {
      final newToken = await refreshAccessToken();
      if (newToken != null) return await deleteProduct(newToken, productId);
    }

    print("Erreur deleteProduct: ${response.body}");
    return false;
  }

  // ===============================
  // CREATE COMMANDE
  // ===============================
  static Future<bool> createOrder(
      String accessToken, List<Map<String, dynamic>> items) async {
    final uri = Uri.parse('$baseUrl/orders/');
    final response = await http.post(uri,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"items": items}));

    if (response.statusCode == 201 || response.statusCode == 200) return true;

    if (response.statusCode == 401) {
      final newToken = await refreshAccessToken();
      if (newToken != null) return await createOrder(newToken, items);
    }

    print("Erreur createOrder: ${response.body}");
    return false;
  }

  // ===============================
  // MÉTHODE INTERNE CREATE / UPDATE
  // ===============================
  static Future<bool> _sendProductRequest({
    required String method,
    required String accessToken,
    int? productId,
    required String name,
    required String description,
    required double price,
    required int quantity,
    File? imageFile,
    Uint8List? webImage,
  }) async {
    Uri uri = method == "POST"
        ? Uri.parse('$baseUrl/products/')
        : Uri.parse('$baseUrl/products/$productId/');

    var request = http.MultipartRequest(method, uri);

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['quantity'] = quantity.toString();

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    } else if (webImage != null) {
      request.files.add(http.MultipartFile.fromBytes('image', webImage, filename: 'upload.jpg'));
    }

    request.headers['Authorization'] = 'Bearer $accessToken';

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print("STATUS: ${response.statusCode}");
    print("BODY: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) return true;

    if (response.statusCode == 401) {
      final newToken = await refreshAccessToken();
      if (newToken != null) {
        return await _sendProductRequest(
          method: method,
          accessToken: newToken,
          productId: productId,
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          imageFile: imageFile,
          webImage: webImage,
        );
      }
    }

    return false;
  }
}