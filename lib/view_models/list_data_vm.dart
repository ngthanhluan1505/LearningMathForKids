import 'package:flutter/foundation.dart';
import 'package:toancungbe/model/lesson_model.dart';
import 'package:toancungbe/model/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

var lessons = <Lesson>[];

Future<List<Lesson>> fetchLessons(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://raw.githubusercontent.com/LungDefault/flutter-json_file/main/lessons.json'));
  return compute(parseLessons, response.body);
}

List<Lesson> parseLessons(String resBody) {
  final par = jsonDecode(resBody).cast<Map<String, dynamic>>();
  return par.map<Lesson>((json) => Lesson.fromJson(json)).toList();
}

User user = User('');

void loadLessons(List<int> data) {
  for (int i = 0; i < lessons.length; i++) {
    lessons[i].setState(data[i]);
  }
}

String dataLessonsState() {
  String data = '';
  for (int i = 0; i < lessons.length; i++) {
    data += lessons[i].state.toString();
  }
  return data;
}

String dataAchievement() {
  String data = '';
  for (int i = 0; i < user.achievements.length; i++) {
    data += user.achievements[i].toString();
  }
  return data;
}
