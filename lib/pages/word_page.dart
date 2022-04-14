import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_it/models/word_game.dart';
import 'package:guess_it/widgets/letter.dart';

import 'package:guess_it/words/words.dart';

enum WordPageState { loading, error, gameStarted, gameLose, gameWin }

class WordPage extends StatefulWidget {
  final String wordId;
  const WordPage({Key? key, required this.wordId}) : super(key: key);

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  WordPageState state = WordPageState.loading;
  late final WordGame game;

  double boxWidth = 0;
  double spaceWidth = 0;
  late List<String> enteredGuesses;

  final textFocusNode = FocusNode();
  final textController = TextEditingController();
  var currentGuess = 0;
  late final Future<DocumentSnapshot> wordDoc;

  @override
  void initState() {
    super.initState();
    fetchWord();
  }

  @override
  void dispose() {
    textFocusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  Future<void> fetchWord() async {
    final doc = await FirebaseFirestore.instance
        .collection('word')
        .doc(widget.wordId)
        .get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    game = WordGame.fromJson(data);

    enteredGuesses = [
      for (int i = 0; i < game.num_of_chances; i++)
        ''.padRight(game.word.length)
    ];

    setState(() {
      state = WordPageState.gameStarted;
    });
  }

  void handleGuess() {
    if (textController.text.toLowerCase() == game.word) {
      setState(() {
        currentGuess++;
        state = WordPageState.gameWin;
      });
    } else {
      currentGuess++;
      if (currentGuess == game.num_of_chances) {
        setState(() {
          state = WordPageState.gameLose;
        });
      }
      textController.clear();
      textFocusNode.requestFocus();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: SizedBox(
          width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
          child: LayoutBuilder(builder: (context, constraints) {
            if (state == WordPageState.gameStarted) {
              double x = constraints.maxWidth /
                  ((game.word.length + 1) + 5 * (game.word.length + 2));
              boxWidth = 5 * x;
              spaceWidth = x;
            }

            return Center(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.05),
                    child: Text(
                      'Guess it',
                      style: TextStyle(fontSize: constraints.maxWidth * 0.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (state == WordPageState.loading)
                    Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth,
                      height: constraints.maxWidth,
                      child: SizedBox(
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxWidth * 0.5,
                        child: CircularProgressIndicator(
                          strokeWidth: constraints.maxWidth * 0.05,
                        ),
                      ),
                    )
                  else if (state == WordPageState.error)
                    Container(
                      child: Text('ERROR'),
                    )
                  else
                    Stack(children: [
                      GestureDetector(
                        onTap: state == WordPageState.gameStarted
                            ? () {
                                textFocusNode.requestFocus();
                              }
                            : null,
                        child: Column(children: [
                          for (int i = 0; i < game.num_of_chances; i++)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int j = 0;
                                        j < game.word.length;
                                        j++) ...[
                                      Letter(
                                          letter: enteredGuesses[i][j],
                                          size: boxWidth,
                                          color: (() {
                                            if (i < currentGuess) {
                                              if (enteredGuesses[i][j] ==
                                                  game.word[j])
                                                return Colors.green;
                                              else if (game.word.contains(
                                                  enteredGuesses[i][j]))
                                                return Colors.yellow;
                                              else
                                                return Colors.grey;
                                            } else if (i == currentGuess) {
                                              return Colors.black;
                                            } else {
                                              return Colors.black;
                                            }
                                          })()),
                                      SizedBox(
                                          width: j != game.word.length - 1
                                              ? spaceWidth
                                              : null)
                                    ]
                                  ],
                                ),
                                SizedBox(height: spaceWidth),
                              ],
                            ),
                          SizedBox(height: boxWidth),
                          if (state == WordPageState.gameStarted)
                            ElevatedButton(
                              onPressed: words.contains(
                                      enteredGuesses[currentGuess]
                                          .replaceAll(RegExp(r'İ'), 'i')
                                          .replaceAll(RegExp(r'I'), 'ı')
                                          .toLowerCase())
                                  ? handleGuess
                                  : null,
                              child: Text(
                                'Guess',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.05),
                              ),
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(
                                          boxWidth * game.word.length +
                                              spaceWidth *
                                                  (game.word.length - 1),
                                          boxWidth))),
                            )
                          else if (state == WordPageState.gameWin)
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'You Win!',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.05),
                              ),
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(
                                          boxWidth * game.word.length +
                                              spaceWidth *
                                                  (game.word.length - 1),
                                          boxWidth)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'You Lose.',
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.05),
                              ),
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(
                                          boxWidth * game.word.length +
                                              spaceWidth *
                                                  (game.word.length - 1),
                                          boxWidth)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                            )
                        ]),
                      ),
                      Opacity(
                        child: TextField(
                          focusNode: textFocusNode,
                          maxLength: game.word.length,
                          controller: textController,
                          onChanged: (value) {
                            setState(() {
                              enteredGuesses[currentGuess] = value
                                  .padRight(game.word.length)
                                  .replaceAll(RegExp(r'İ'), 'i')
                                  .replaceAll(RegExp(r'I'), 'ı')
                                  .toLowerCase();
                            });
                          },
                        ),
                        opacity: 0,
                      )
                    ])
                ],
              ),
            );
          }),
        ),
      );
    }));
  }
}
