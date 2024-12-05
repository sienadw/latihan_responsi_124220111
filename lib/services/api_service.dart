import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const String baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  Future<List<Article>> getArticles(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/$type/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<Article> getArticleDetails(String type, int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$type/$id/'));

    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load article details');
    }
  }
}
