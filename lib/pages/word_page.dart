import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_it/models/word_game.dart';
import 'package:guess_it/widgets/letter.dart';

class WordPage extends StatefulWidget {
  final String wordId;
  WordPage({Key? key, required this.wordId}) : super(key: key);

  @override
  State<WordPage> createState() => _HomePageState();
}

class _HomePageState extends State<WordPage> {
  List<List<TextEditingController>> letterControllers = [];

  @override
  void dispose() {
    for (int i = 0; i < letterControllers.length; i++) {
      letterControllers.add([]);
      for (int j = 0; j < letterControllers[0].length; j++) {
        letterControllers[i][j].dispose();
      }
    }
    super.dispose();
  }

  Future<DocumentSnapshot> fetchDoc() async {
    return FirebaseFirestore.instance
        .collection('word')
        .doc(widget.wordId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Guess it',
              style: TextStyle(fontSize: 100),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
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
                    double x = constraints.maxWidth /
                        ((game.word.length + 1) + 5 * (game.word.length + 2));
                    double boxWidth = 5 * x;
                    double spaceWidth = x;

                    for (int i = 0; i < game.num_of_chances; i++) {
                      letterControllers.add([]);
                      for (int j = 0; j < game.word.length; j++) {
                        letterControllers[i].add(TextEditingController());
                      }
                    }

                    return Column(children: [
                      for (int i = 0; i < game.num_of_chances; i++) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int j = 0; j < game.word.length; j++) ...[
                              Letter(
                                  letter: '',
                                  size: boxWidth,
                                  controller: letterControllers[i][j]),
                              SizedBox(
                                  width: j != game.word.length - 1
                                      ? spaceWidth
                                      : null)
                            ]
                          ],
                        ),
                        SizedBox(height: spaceWidth)
                      ]
                    ]);
                  }

                  return const SizedBox(
                      width: 500,
                      height: 500,
                      child: CircularProgressIndicator(
                        strokeWidth: 50,
                      ));
                }),
          ],
        ),
      );
    }));
  }
}
