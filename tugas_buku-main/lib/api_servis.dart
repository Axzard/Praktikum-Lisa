import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model_book.dart';
import 'api_auth.dart';

const String baseUrl = 'https://hppms-sabala.my.id/api/books';

Future<Map<String, String>> getAuthHeader() async {
  final token = await getToken();
  return {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Future<List<Book>> fetchBooks() async {
  try {
    final headers = await getAuthHeader();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> res = jsonDecode(response.body);
      final List list = res['data']['data'];
      return list.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data buku");
    }
  } catch (e) {
    rethrow;
  }
}

Future<Book> addBook(String title, String author, String description) async {
  final headers = await getAuthHeader();
  final jsonBody = {
    "title": title,
    "author": author,
    "description": description,
  };

  final response = await http.post(
    Uri.parse(baseUrl),
    headers: headers,
    body: jsonEncode(jsonBody),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body)['data'];
    return Book.fromJson(data);
  } else {
    throw Exception("Gagal menambahkan buku: ${response.body}");
  }
}

Future<void> updateBook(int id, String title, String author, String description) async {
  final headers = await getAuthHeader();
  final jsonBody = {
    "title": title,
    "author": author,
    "description": description,
  };

  final response = await http.put(
    Uri.parse("$baseUrl/$id"),
    headers: headers,
    body: jsonEncode(jsonBody),
  );

  if (response.statusCode != 200) {
    throw Exception("Gagal memperbarui buku: ${response.body}");
  }
}

Future<void> deleteBook(int id) async {
  try {
    final headers = await getAuthHeader();
    print("📡 DELETE: $baseUrl/$id"); // log request

    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print("✅ Buku berhasil dihapus"); // log berhasil
    } else if (response.statusCode == 403) {
      print("Bukan pemilik buku"); // log gagal
      throw Exception("Bukan pemilik buku");
    } else {
      print("❌ Gagal menghapus buku: ${response.body}"); // log error lain
      throw Exception("Gagal menghapus buku: ${response.body}");
    }
  } catch (e) {
    rethrow;
  }
}

