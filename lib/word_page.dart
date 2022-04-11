import 'package:flutter/material.dart';

class WordPage extends StatefulWidget {
  final String wordId;
  const WordPage({Key? key, required this.wordId}) : super(key: key);

  @override
  State<WordPage> createState() => _HomePageState();
}

class _HomePageState extends State<WordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.wordId),
          ],
        ),
      ),
    );
  }
}
