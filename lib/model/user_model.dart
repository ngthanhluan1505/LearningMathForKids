import 'package:toancungbe/resources/my_lib.dart';

class User {
  String _nameUser;
  late int star, candy;
  late List<int> achievements;

  User(this._nameUser);
  String get nameUser => _nameUser;
  void setName(String name) => _nameUser = name;

  Storage storage = Storage();

  Future<String> loading() async {
    var data = '';
    await storage.readData('User.txt').then((String value) {
      data = value;
    });
    return data;
  }

  void writing(String data) {
    storage.writeData(data, 'User.txt');
  }

  Future<int> loadStar() async {
    var data = '';
    await storage.readData('Star.txt').then((String value) {
      data = value;
    });
    return int.parse(data);
  }

  void writeStar(String data) {
    storage.writeData(data, 'Star.txt');
  }

  Future<int> loadCandy() async {
    var data = '';
    await storage.readData('Candy.txt').then((String value) {
      data = value;
    });
    return int.parse(data);
  }

  void writeCandy(String data) {
    storage.writeData(data, 'Candy.txt');
  }

  void writeLessonState(String data) {
    storage.writeData(data, 'Lesson.txt');
  }

  void writeAchievement(String data) {
    storage.writeData(data, 'Achievement.txt');
  }

  Future<List<int>> loadLessonState() async {
    var data = '';
    await storage.readData('Lesson.txt').then((String value) {
      data = value;
    });
    var result = <int>[], i = 0;
    while (true) {
      try {
        var d = data.substring(i, i + 1);
        result.add(int.parse(d));
        i++;
      } catch (ex) {
        break;
      }
    }
    return result;
  }

  Future<List<int>> loadAchievement() async {
    var data = '';
    await storage.readData('Achievement.txt').then((String value) {
      data = value;
    });
    var result = <int>[], i = 0;
    while (true) {
      try {
        var d = data.substring(i, i + 1);
        result.add(int.parse(d));
        i++;
      } catch (ex) {
        break;
      }
    }
    return result;
  }
}
