import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../words/words.dart';

class CreateWordPage extends StatefulWidget {
  const CreateWordPage({Key? key}) : super(key: key);

  @override
  State<CreateWordPage> createState() => _CreateWordPageState();
}

class _CreateWordPageState extends State<CreateWordPage> {
  final _wordController = TextEditingController();
  bool isValidWord = false;
  String generatedLink = '';
  bool isCopied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Guess it',
                      style: TextStyle(fontSize: constraints.maxWidth * 0.2),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.75,
                      child: TextField(
                        autofocus: true,
                        maxLength: 10,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: constraints.maxWidth * 0.05,
                            color: Colors.black),
                        onChanged: (enteredWord) {
                          if (words.contains(enteredWord.toLowerCase())) {
                            setState(() {
                              isValidWord = true;
                            });
                          } else {
                            setState(() {
                              isValidWord = false;
                            });
                          }
                        },
                        controller: _wordController,
                      ),
                    ),
                    SizedBox(
                        width: constraints.maxWidth * 0.75,
                        height: 100,
                        child: generatedLink == ''
                            ? ElevatedButton(
                                onPressed: isValidWord && generatedLink == ''
                                    ? () async {
                                        if (isValidWord) {
                                          DocumentReference doc =
                                              await FirebaseFirestore.instance
                                                  .collection('word')
                                                  .add({
                                            'word': _wordController.text
                                                .toLowerCase(),
                                            'num_of_chances': 6,
                                            'time_in_seconds': -1,
                                          });
                                          setState(() {
                                            generatedLink =
                                                'https://guess-it-a4bab.web.app/wid/${doc.id}';
                                          });
                                        }
                                      }
                                    : null,
                                child: Text(
                                  'Create Word Game',
                                  style: Theme.of(context).textTheme.headline6,
                                ))
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isCopied = true;
                                  });
                                  Clipboard.setData(
                                      ClipboardData(text: generatedLink));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.copy),
                                    const SizedBox(width: 16),
                                    Text(
                                      isCopied ? 'Copied' : 'Tap to Copy',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    )
                                  ],
                                )))
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
