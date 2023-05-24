import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/article.dart';

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '68654fc381fd40f49b18651031d49b61';
  static String _category = '';
  static final String _country = 'us';
  // static final String _range = 'top-headlines';
  static String _sortBy = '';
  static String _searchKey = '';

  Future<ArticleResult> topHeadlines(String category) async {
    _category = category;
    print(_searchKey);

    final response = await http.get(Uri.parse(_baseUrl +
        'top-headlines?country=$_country&category=$_category&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return ArticleResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<ArticleResult> searchNews(String keywoard) async {
    _searchKey = Uri.encodeFull(keywoard);
    print(_searchKey);

    var response = await http.get(Uri.parse(_baseUrl +
        'everything?q=$_searchKey&searchIn=title&sortBy=popularity&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return ArticleResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('News not found');
    }
  }
}
