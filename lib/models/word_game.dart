class WordGame {
  late String word;
  late int time_in_seconds;
  late int num_of_chances;

  WordGame(
      {required this.word,
      required this.time_in_seconds,
      required this.num_of_chances});

  WordGame.fromJson(json) {
    word = json['word'] as String;
    time_in_seconds = json['time_in_seconds'] as int;
    num_of_chances = json['num_of_chances'] as int;
  }
}
