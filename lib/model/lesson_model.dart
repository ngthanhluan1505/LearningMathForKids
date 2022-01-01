import 'package:toancungbe/model/game_model.dart';

class Lesson {
  int _id, _state;
  String _name, _key, _image;
  Game _game;

  Lesson(this._id, this._name, this._key, this._image, this._game, this._state);
  int get id => _id;
  int get state => _state;
  String get name => _name;
  String get key => _key;
  Game get game => _game;
  String get image => _image;

  void setState(int state) {
    _state = state;
  }

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        json['id_lesson'] as int,
        json['name_lesson'] as String,
        json['key'] as String,
        json['image'] as String,
        Game(json['id_Game'] as int, json['type'] as String,
            json['level'] as int),
        json['state'] as int);
  }
}
