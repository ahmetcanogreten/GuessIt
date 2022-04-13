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
  final Color color;
  const Letter(
      {Key? key, required this.letter, required this.size, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(colors: [
              if (color == Colors.green) ...[
                Color.fromARGB(255, 5, 75, 8),
                Colors.green,
                Color.fromARGB(255, 5, 75, 8)
              ] else if (color == Colors.yellow) ...[
                Color.fromARGB(255, 88, 80, 6),
                Color.fromARGB(255, 158, 146, 38),
                Color.fromARGB(255, 88, 80, 6)
              ] else if (color == Colors.grey) ...[
                Color.fromARGB(255, 82, 82, 82),
                Color.fromARGB(255, 163, 162, 162),
                Color.fromARGB(255, 82, 82, 82)
              ] else ...[
                Colors.black,
                Color.fromARGB(255, 83, 83, 83),
                Colors.black
              ]
            ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: Center(
          child: Text(
            letter
                .replaceAll(RegExp(r'i'), 'İ')
                .replaceAll(RegExp(r'I'), 'ı')
                .toUpperCase(),
            style: TextStyle(fontSize: size * 0.75),
          ),
        ));
  }
}
