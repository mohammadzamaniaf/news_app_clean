import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/theme/app_theme.dart';
import '/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import '/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import '/features/daily_news/presentation/screens/home/daily_news.dart';
import '/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      // The first thing the happens when bloc is created is to add call articles event
      // BlocProvider.of<RemoteArticlesBloc>(context) == s1()
      create: (context) => sl()
        ..add(
          const GetArticles(),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const DailyNews(),
      ),
    );
  }
}
