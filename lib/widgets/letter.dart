import 'package:flutter/material.dart';

Widget? noCounter(
  BuildContext context, {
  required int currentLength,
  required int? maxLength,
  required bool isFocused,
}) {
  return null;
}

class Letter extends StatelessWidget {
  final String letter;
  final double size;
  final TextEditingController controller;
  const Letter(
      {Key? key,
      required this.letter,
      required this.size,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(colors: [
              Colors.black,
              Color.fromARGB(255, 80, 80, 80),
              Colors.black
            ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: TextField(
          textInputAction: TextInputAction.next,
          expands: true,
          minLines: null,
          maxLines: null,
          controller: controller,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            controller.text = value.toUpperCase();
          },
          style: TextStyle(fontSize: size * 0.60),
          maxLength: 1,
          cursorWidth: 0,
          buildCounter: noCounter,
          decoration: const InputDecoration(
              border: InputBorder.none, semanticCounterText: ''),
        ));
  }
}
