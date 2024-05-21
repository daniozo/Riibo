import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../models/business.dart';

class ArticleService {
  final String baseUrl = 'http://192.168.11.111:3000';

  Future<List<Article>> getRecentArticles() async {
    final response = await http.get(Uri.parse('$baseUrl/api/articles/recent'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Article> articles =
          data.map((json) => Article.fromJson(json)).toList();
      return articles;
    } else {
      throw Exception('Erreur au chargement des articles');
    }
  }

  Future<List<Article>> getArticlesByFilters(
    String category, {
    bool? within1km,
    bool? within2km,
    bool? newArticles,
    bool? favoriteArticles,
    List<double>? userCoordinates,
  }) async {
    String filters = '';

    if (within1km != null && within1km) {
      filters += '&within1km=true';
    }
    if (within2km != null && within2km) {
      filters += '&within2km=true';
    }
    if (newArticles != null && newArticles) {
      filters += '&newArticles=true';
    }
    if (favoriteArticles != null && favoriteArticles) {
      filters += '&favoriteArticles=true';
    }

    if (userCoordinates != null && userCoordinates.length == 2) {
      filters +=
          '&userLatitude=${userCoordinates[0]}&userLongitude=${userCoordinates[1]}';
    }

    final response = await http.get(Uri.parse(
        '$baseUrl/api/articles/by-filters?category=$category$filters'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Article> articles =
          data.map((json) => Article.fromJson(json)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles by filters');
    }
  }

  Future<List<Business>> getBusinesses() async {
    final response = await http.get(Uri.parse('$baseUrl/api/businesses'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Business> businesses =
          data.map((json) => Business.fromJson(json)).toList();
      return businesses;
    } else {
      throw Exception('Erreur au chargement');
    }
  }
}
