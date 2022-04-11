import 'package:flutter/material.dart';

class NonPage extends StatefulWidget {
  const NonPage({Key? key}) : super(key: key);

  @override
  State<NonPage> createState() => _NonPageState();
}

class _NonPageState extends State<NonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'There is no such page.',
            ),
          ],
        ),
      ),
    );
  }
}
