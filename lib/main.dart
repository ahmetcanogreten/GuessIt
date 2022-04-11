import 'package:flutter/material.dart';
import 'package:guess_it/create_word_page.dart';
import 'package:guess_it/non_page.dart';

import 'package:go_router/go_router.dart';

import 'package:guess_it/home_page.dart';
import 'package:guess_it/word_page.dart';

void main() {
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                const HomePage()),
        GoRoute(
            name: 'word_create',
            path: '/word/create',
            builder: (BuildContext context, GoRouterState state) {
              print('Heyy');
              return const CreateWordPage();
            }),
        GoRoute(
            path: '/word/:wid',
            builder: (BuildContext context, GoRouterState state) {
              return WordPage(
                  wordId: state.params.containsKey('wid')
                      ? state.params['wid']!
                      : '');
            }),
      ],
      errorBuilder: (BuildContext context, GoRouterState state) {
        print(state.error);
        return const NonPage();
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
