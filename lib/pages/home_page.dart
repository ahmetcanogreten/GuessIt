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
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Guess it',
                      style: TextStyle(fontSize: constraints.maxWidth * 0.2),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(constraints.maxWidth * 0.5, 100))),
                        onPressed: () {
                          GoRouter.of(context).go('/word/create');
                        },
                        child: Text(
                          'Create A Game',
                          style:
                              TextStyle(fontSize: constraints.maxWidth * 0.05),
                        ))
                  ],
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
