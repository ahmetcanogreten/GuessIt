import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_it/themes/cubit/theme_cubit.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SizedBox(
                width: constraints.maxWidth > 960 ? 960 : constraints.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Guess it',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: constraints.maxWidth * 0.2 > 200
                              ? 200
                              : constraints.maxWidth * 0.2),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.75,
                      child: BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          return TextField(
                            autofocus: true,
                            maxLength: 10,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: state is ThemeDark
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: constraints.maxWidth * 0.05),
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
                          );
                        },
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
                                                'https://guess-it-a4bab.web.app/word/${doc.id}';
                                          });
                                        }
                                      }
                                    : null,
                                child: Text(
                                  'Create Word Game',
                                ),
                                style: ButtonStyle(
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                            Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    fontSize:
                                                        constraints.maxWidth *
                                                            0.03)),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(Size(
                                            constraints.maxWidth * 0.75, 200))))
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
        ],
      ));
    });
  }
}
