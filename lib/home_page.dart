import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_it/create_word_page.dart';

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
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Guess it',
              style: TextStyle(fontSize: 100),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/word/');
                },
                child: Text('Create Word Game')),
          ],
        ),
      ),
    );
  }
}
