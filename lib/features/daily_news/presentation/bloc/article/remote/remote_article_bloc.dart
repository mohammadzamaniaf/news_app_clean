import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/resources/data_state.dart';
import '../../../../domain/usecases/get_article.dart';
import '/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import '/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
    GetArticles event,
    Emitter<RemoteArticleState> emit,
  ) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print('Data Success');
      emit(
        RemoteArticlesDone(dataState.data!),
      );
    }

    if (dataState is DataFailed) {
      print('Data Failed');
      print(dataState.error!.error);
      emit(
        RemoteArticlesError(dataState.error!),
      );
    }
  }
}
