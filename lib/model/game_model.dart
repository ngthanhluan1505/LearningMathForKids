import 'package:toancungbe/view_models/list_data_vm.dart';

class Game {
  final int _id;
  final String _type;
  int _level;

  List<int> result = [];
  List<int> exam = [];

  Game(this._id, this._type, this._level);

  int get level => _level;
  int get id => _id;
  String get type => _type;

  void setLevel(int level) {
    _level = level;
  }

  void rule() {} // luat choi

  void timing() {} // thoi gian

  int suggestion(List<int> exams) {
    return exams[0];
  }

  List<int> total(List<int> result) {
    List<int> rs = [0, 0];
    int x = 0;
    for (int i = 0; i < result.length; i++) {
      x = result[i] == 1 ? x + 1 : x;
    }
    rs[0] = x < 3
        ? 0
        : x < 6
            ? 1
            : x == 10
                ? 3
                : 2;
    rs[1] = x < 6 ? 0 : 1;
    user.star += rs[0];
    user.candy += rs[1];
    user.writeStar(user.star.toString());
    user.writeCandy(user.candy.toString());
    return rs;
  }
}
