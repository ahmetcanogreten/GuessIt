import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:guess_it/create_word_page.dart';
import 'package:guess_it/non_page.dart';
import 'package:guess_it/home_page.dart';
import 'package:guess_it/word_page.dart';

void main() async {
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
            path: '/word/create',
            builder: (BuildContext context, GoRouterState state) =>
                const CreateWordPage()),
        GoRoute(
            path: '/wid/:wid',
            builder: (BuildContext context, GoRouterState state) => WordPage(
                wordId: state.params.containsKey('wid')
                    ? state.params['wid']!
                    : '')),
      ],
      errorBuilder: (BuildContext context, GoRouterState state) {
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
