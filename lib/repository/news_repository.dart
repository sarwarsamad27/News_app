import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shoppinghere/model/categories_news_model.dart';

import '../model/News_channel_headlines_model.dart';

class Repository{

  Future<news_channel_headlines_model> fetchNewsChannel(String channelName)async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=0a79e8f0a8fa499ea7c8ce90d4e7a657';

    final response =await http.get(Uri.parse(url));
    // if (kDebugMode) {
    //   print(response.body);
    // }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return news_channel_headlines_model.fromJson(body);
    }
    throw Exception('error');
  }





  Future<CategoriesNewsModel> fetchCategories(String category) async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=0a79e8f0a8fa499ea7c8ce90d4e7a657';

    final response =await http.get(Uri.parse(url));
    // if (kDebugMode) {
    //   print(response.body);
    // }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('error');
  }
}