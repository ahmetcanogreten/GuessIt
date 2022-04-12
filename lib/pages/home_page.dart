import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Guess it',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(constraints.maxWidth * 0.5, 100))),
                  onPressed: () {
                    GoRouter.of(context).go('/word/create');
                  },
                  child: Text(
                    'Create A Game',
                    style: Theme.of(context).textTheme.headline3,
                  ));
            }),
          ],
        ),
      ),
    );
  }
}
