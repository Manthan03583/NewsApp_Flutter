import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/services/news_services.dart';
import 'package:newsapp/utils/constants.dart';

class Newscontroller {
  List<News> newsList = [];

  //converting top headline api list data to News data type list
  Future<List<News>> fetchNews() async {
    try {
      final newsData = await NewsService.fetchNewsData();
      return newsList = newsData.map((data) {
        return News(
            title: data['title'] ?? Constant.placeholderTitle,
            description: data['description'] ?? Constant.placholderDescription,
            imageURL: data['urlToImage'] ?? Constant.placeholderImage,
            source: data['source']['name'] ?? Constant.placeholderSource);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //converting query api list data to News data type list
  Future<List<News>> searchNews(String query) async {
    try {
      final searchedNewsData = await NewsService.searchNewsData(query);
      return newsList = searchedNewsData.map((data) {
        return News(
            title: data['title'] ?? Constant.placeholderTitle,
            description: data['description'] ?? Constant.placholderDescription,
            imageURL: data['urlToImage'] ?? Constant.placeholderImage,
            source: data['source']['name'] ?? Constant.placeholderSource);
      }).toList();
          
    } catch (e) {
      throw Exception(e);
    }
  }
}
