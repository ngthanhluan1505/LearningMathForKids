//Hái trái cây

import 'package:toancungbe/model/game_model.dart';
import 'package:toancungbe/resources/my_lib.dart';

class PickingFruit extends Game {
  PickingFruit(int id, String type, int level) : super(id, type, level);

  int checkOddEven(int n) {
    return n % 2 == 0 ? 0 : 1;
  }

  List<int> createExam(int domain, int quantity) {
    List<int> ex = [];
    List<int> mart = [];
    int temp = 0;
    for (int i = 0; i < quantity / 2; i++) {
      do {
        temp = random(domain + 1);
        temp = temp == 0 ? 1 : temp;
      } while (checkOddEven(temp) == 0 || inMart(mart, temp));
      mart.add(temp);
      ex.add(temp);
    }
    for (int i = 0; i < quantity / 2; i++) {
      do {
        temp = random(domain + 1);
        temp = temp == 0 ? 2 : temp;
      } while (checkOddEven(temp) == 1 || inMart(mart, temp));
      mart.add(temp);
      ex.add(temp);
    }
    blend(ex);
    return ex;
  }
}
