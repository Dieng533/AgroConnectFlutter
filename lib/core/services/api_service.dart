import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ Android Emulator → 10.0.2.2
  // ⚠️ Téléphone physique → IP locale (ex: 192.168.1.10)
  static const String baseUrl = "http://127.0.0.1:8000/api";

  // ==========================
  // REGISTER
  // ==========================
  static Future<Map<String, dynamic>> register(
      String username,
      String email,
      String password,
      String role) async {

    if (role == 'admin') {
      return {
        "error": "La création d'un compte administrateur n'est pas autorisée."
      };
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "role": role,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        return {"error": data.toString()};
      }
    } catch (e) {
      return {"error": "Impossible de se connecter au serveur"};
    }
  }

  // ==========================
  // LOGIN (JWT)
  // ==========================
  static Future<Map<String, dynamic>> login(
      String email,
      String password) async {

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/token/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data; // contient access + refresh
      } else if (response.statusCode == 401) {
        return {"error": "Email ou mot de passe incorrect"};
      } else {
        return {"error": data.toString()};
      }
    } catch (e) {
      return {"error": "Impossible de se connecter au serveur"};
    }
  }

  // ==========================
  // GET PROFILE (récupérer rôle)
  // ==========================
  static Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/profile/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        return {"error": data.toString()};
      }
    } catch (e) {
      return {"error": "Impossible de récupérer le profil"};
    }
  }
}