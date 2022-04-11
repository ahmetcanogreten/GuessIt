import 'package:flutter/material.dart';
import 'words.dart';

class CreateWordPage extends StatefulWidget {
  const CreateWordPage({Key? key}) : super(key: key);

  @override
  State<CreateWordPage> createState() => _CreateWordPageState();
}

class _CreateWordPageState extends State<CreateWordPage> {
  final _wordController = TextEditingController();
  bool isValidWord = false;
  String generatedLink = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Guess it',
            style: TextStyle(fontSize: 100),
            textAlign: TextAlign.center,
          ),
          const Text('Enter the word'),
          Container(
            color: isValidWord ? Colors.green : Colors.red,
            child: TextField(
              onChanged: (enteredWord) {
                if (words.contains(enteredWord)) {
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
          ElevatedButton(
              onPressed: isValidWord
                  ? () {
                      if (isValidWord) {
                        setState(() {
                          generatedLink = 'GENERATED_LINK';
                        });
                      }
                    }
                  : null,
              child: Text('Create Word Game')),
          Row(
            children: [Text('Link : '), Text(generatedLink)],
          )
        ],
      ),
    );
  }
}
