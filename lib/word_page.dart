import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_it/models/word_game.dart';

class WordPage extends StatefulWidget {
  final String wordId;
  const WordPage({Key? key, required this.wordId}) : super(key: key);

  @override
  State<WordPage> createState() => _HomePageState();
}

class _HomePageState extends State<WordPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<DocumentSnapshot> fetchDoc() async {
    return FirebaseFirestore.instance
        .collection('word')
        .doc(widget.wordId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<DocumentSnapshot>(
                future: fetchDoc(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("There is no game with this link");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    WordGame game = WordGame.fromJson(data);
                    return Text(
                      widget.wordId,
                      style: TextStyle(fontSize: 100),
                      textAlign: TextAlign.center,
                    );
                  }

                  return Text("loading");
                }),
          ],
        ),
      ),
    );
  }
}
