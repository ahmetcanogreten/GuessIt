import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guess_it/themes/cubit/theme_cubit.dart';
import 'firebase_options.dart';

import 'screens/barrel_screens.dart';
import 'package:guess_it/themes/themes.dart';

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
            path: '/word',
            builder: (BuildContext context, GoRouterState state) =>
                const CreateWordPage()),
        GoRoute(
            path: '/word/:wid',
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
    return BlocProvider(
        create: (_) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: _router.routerDelegate,
              routeInformationParser: _router.routeInformationParser,
              darkTheme: darkTheme,
              theme: state is ThemeDark ? darkTheme : lightTheme,
            );
          },
        ));
  }
}
