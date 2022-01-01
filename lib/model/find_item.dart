// Tìm đồ vật
import 'package:toancungbe/model/game_model.dart';
import 'package:toancungbe/resources/my_lib.dart';

class FindItem extends Game {
  FindItem(int id, String type, int level) : super(id, type, level);
  List<int> createExam(int quantity) {
    var ex = <int>[];
    for (int i = 0; i < quantity; i++) {
      int k = random(4);
      k = k == 4 ? random(3) : k;
      ex.add(k);
    }
    return ex;
  }
}
