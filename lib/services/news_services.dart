import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/utils/constants.dart';

class NewsService {

  //GET topheadlines of india
  static Future<List<dynamic>> fetchNewsData() async {
    const apiUrl = '/v2/top-headlines';
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${Constant.apiKey}',
    };

    final Map<String, String> parameters = {
      'country': 'in',
    };

    final uri = Uri.https(Constant.baseUrl,apiUrl,parameters);
    final respone = await http.get(uri,headers: headers);

    if (respone.statusCode == 200) {
      final jsonResponse = json.decode(respone.body);
      return jsonResponse['articles'];
    } else {
      throw Exception('Failed to fetch news data');
    }
  }

  //GET search
  static Future<List<dynamic>> searchNewsData(String query) async{
    const apiUrl = '/v2/everything';
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${Constant.apiKey}',
    };

    final Map<String, String> parameters = {
      'q': query,
    };

    final uri = Uri.https(Constant.baseUrl,apiUrl,parameters);
    final respone = await http.get(uri,headers: headers);

    if (respone.statusCode == 200) {
      final jsonResponse = json.decode(respone.body);
      return jsonResponse['articles'];
    } else {
      throw Exception('Failed to fetch search news data');
    }
  }
  
}
