// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      word: json['word'] as String,
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      rating: json['rating'] as int? ?? -1,
      timeInSeconds: json['timeInSeconds'] as int? ?? -1,
      numOfChances: json['numOfChances'] as int? ?? 5,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'word': instance.word,
      'id': instance.id,
      'userId': instance.userId,
      'rating': instance.rating,
      'timeInSeconds': instance.timeInSeconds,
      'numOfChances': instance.numOfChances,
    };
