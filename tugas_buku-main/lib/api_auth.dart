import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "https://hppms-sabala.my.id/api";
const String registerEndpoint = "/register";
const String loginEndpoint = "/login";

// ==================== REGISTER ====================
Future<Map<String, dynamic>> registerUser({
  required String name,
  required String username,
  required String email,
  required String password,
  required String phone,
}) async {
  final url = baseUrl + registerEndpoint;
  final body = {
    "name": name,
    "username": username,
    "email": email,
    "password": password,
    "password_confirmation": password,
    "phone": phone,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    body: jsonEncode(body),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body)['data'];
    final token = data['token'];
    await saveToken(token);
  }

  return {"status": response.statusCode, "body": jsonDecode(response.body)};
}

// ==================== LOGIN ====================
Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final url = baseUrl + loginEndpoint;
  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    final token = jsonDecode(response.body)['data']['token'];
    await saveToken(token);
  }

  return {"status": response.statusCode, "body": jsonDecode(response.body)};
}

// ==================== TOKEN ====================
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}
