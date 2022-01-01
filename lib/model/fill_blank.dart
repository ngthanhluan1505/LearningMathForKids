// Điền vào chổ trống

import 'package:toancungbe/model/game_model.dart';

class FillBlank extends Game {
  FillBlank(int id, String type, int level) : super(id, type, level);

  List<int> createExam(int location, int left, int rigth, String caculation) {
    List<int> ex = [];
    switch (location) {
      case 0:
        {
          if (caculation == '+') {
            ex.add(rigth - left);
          } else {
            ex.add(rigth + left);
          }
          break;
        }
      case 1:
        {
          if (caculation == '+') {
            ex.add(rigth - left);
          } else {
            ex.add(left - rigth);
          }
          break;
        }
      case 2:
        {
          if (caculation == '+') {
            ex.add(rigth + left);
          } else {
            ex.add(left - rigth);
          }
          break;
        }
    }
    ex.add(location);
    ex.add(left);
    ex.add(rigth);
    return ex;
  }
}
