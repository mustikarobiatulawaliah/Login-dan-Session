import 'package:examplebloc/bloc/addnews_bloc.dart';
import 'package:examplebloc/bloc/detail_bloc.dart';
import 'package:examplebloc/bloc/editnews_bloc.dart';
import 'package:examplebloc/bloc/managenews_bloc.dart';
import 'package:examplebloc/repository/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/login_bloc.dart';
import 'package:examplebloc/layout/homepage.dart';
import 'package:examplebloc/repository/login_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => LoginRepository(),
          ),
          RepositoryProvider(
            create: (context) => NewsRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LoginBloc(loginRepository: context.read<LoginRepository>())
                    ..add(const InitLogin()),
            ),
            BlocProvider(
                create: (context) => AddnewsBloc(
                    newsRepository: context.read<NewsRepository>())),
            BlocProvider(
                create: (context) => ManagenewsBloc(
                    newsRepository: context.read<NewsRepository>())),
            BlocProvider(
                create: (context) =>
                    DetailBloc(newsRepository: context.read<NewsRepository>())),
            BlocProvider(
                create: (context) => EditnewsBloc(
                    newsRepository: context.read<NewsRepository>())),
          ],
          child: MaterialApp(
            title: "Home",
            home: HomePage(),
          ),
        ));
  }
}
