import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_it/themes/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: Stack(alignment: Alignment.centerRight, children: [
        Center(
          child: SizedBox(
              width: constraints.maxWidth > 960 ? 960 : constraints.maxWidth,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Guess it',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: constraints.maxWidth * 0.2 > 200
                              ? 200
                              : constraints.maxWidth * 0.2),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(constraints.maxWidth * 0.75, 200))),
                        onPressed: () {
                          GoRouter.of(context).go('/word');
                        },
                        child: Text('Create A Game',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: constraints.maxWidth * 0.03)))
                  ],
                ),
              )),
        ),
        Positioned(
          right: constraints.maxWidth * 0.05,
          child: IconButton(
              iconSize: constraints.maxWidth * 0.05,
              onPressed: () {
                context.read<ThemeCubit>().changeTheme();
              },
              icon: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) => state is ThemeDark
                      ? const SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Icon(Icons.dark_mode_outlined),
                          ),
                        )
                      : const Icon(Icons.light_mode, color: Colors.black))),
        )
      ]));
    });
  }
}
