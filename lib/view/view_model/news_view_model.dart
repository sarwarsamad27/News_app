

import 'package:shoppinghere/model/News_channel_headlines_model.dart';
import 'package:shoppinghere/model/categories_news_model.dart';
import 'package:shoppinghere/repository/news_repository.dart';

class NewViewModel {

  final _rep = Repository();

  Future<news_channel_headlines_model> fetchNewsChannel(
      String channelName) async {
    final response = await _rep.fetchNewsChannel(channelName);

    return response;
  }


  Future<CategoriesNewsModel> fetchCategories(String category) async {
    final response = await _rep.fetchCategories(category);

    return response;
  }
}