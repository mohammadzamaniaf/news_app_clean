import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/widgets/loader.dart';
import '/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import '/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import '/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() => AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticlesLoading) {
          return const Loader();
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index) {
              return ArticleTile(
                article: state.articles![index],
              );
            },
          );
        }
        return const Center(
          child: Text('Unknow Error Occured! Daily News View'),
        );
      },
    );
  }
}
