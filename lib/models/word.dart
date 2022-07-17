import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  String word;

  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String userId;

  @JsonKey(defaultValue: -1)
  int rating;

  @JsonKey(defaultValue: -1)
  int timeInSeconds;

  @JsonKey(defaultValue: 5)
  int numOfChances;

  Word(
      {required this.word,
      required this.id,
      required this.userId,
      required this.rating,
      required this.timeInSeconds,
      required this.numOfChances});

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
}
