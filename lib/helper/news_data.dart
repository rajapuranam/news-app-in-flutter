import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/models/news_article.dart';

class News {
  String apiKey = '9d73d0057a9d43f48724e84d5ac83616';
  List<NewsArticle> newsList = [];

  helper(response) {
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsArticle article = NewsArticle(
            title: element['title'],
            imgUrl: element['urlToImage'],
            postUrl: element['url'],
            sourceName: element['source']['name'],
          );
          newsList.add(article);
        }
      });
    }
  }

  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&sortBy=publishedAt&language=en&apiKey=$apiKey';

    var response = await http.get(url);
    helper(response);
  }

  Future<void> getCategoryNews({String category}) async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apiKey';

    var response = await http.get(url);
    helper(response);
  }

  Future<void> getSearchNews({String search}) async {
    String url =
        'http://newsapi.org/v2/top-headlines?q=$search&sortBy=publishedAt&language=en&apiKey=$apiKey';

    var response = await http.get(url);
    helper(response);
  }
}
