// Sắp xếp chổ ngồi

import 'package:toancungbe/model/game_model.dart';
import 'package:toancungbe/resources/my_lib.dart';

class ArrangeSeat extends Game {
  ArrangeSeat(int id, String type, int level) : super(id, type, level);
  void bubbleSort(List<int> exam, int flag) {
    int i, j, n = exam.length;
    if (flag == 0) {
      for (i = 0; i <= n - 2; i++)
        // ignore: curly_braces_in_flow_control_structures
        for (j = n - 1; j >= i + 1; j--) {
          if (exam[j] < exam[j - 1]) {
            int temp = exam[j];
            exam[j] = exam[j - 1];
            exam[j - 1] = temp;
          }
        }
    } else
      // ignore: curly_braces_in_flow_control_structures
      for (i = 0; i <= n - 2; i++) {
        for (j = n - 1; j >= i + 1; j--) {
          if (exam[j] > exam[j - 1]) {
            int temp = exam[j];
            exam[j] = exam[j - 1];
            exam[j - 1] = temp;
          }
        }
      }
  }

  List<int> createExam(int domain, int quantity) {
    List<int> ex = [];
    List<int> mart = [];
    for (int i = 0; i < quantity; i++) {
      mart.add(0);
    }
    for (int i = 0; i < quantity; i++) {
      int t;
      do {
        t = random(domain);
      } while (inMart(mart, t));
      mart.add(t);
      ex.add(t);
    }
    return ex;
  }
}
