import 'dart:io';

import 'package:dio/dio.dart';

import '/core/constants/constants.dart';
import '/core/resources/data_state.dart';
import '/features/daily_news/data/data_source/remote/news_api_service.dart';
import '/features/daily_news/data/models/article.dart';
import '/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // print(
        //     'Before: *********************************************************');
        // // TODO: Data is null from here.
        // print(httpResponse.data);
        // print(
        //     'After: *********************************************************');
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
