//Trắc nghiệm
import 'package:toancungbe/model/game_model.dart';
import 'package:toancungbe/resources/my_lib.dart';

class MultipleChoice extends Game {
  MultipleChoice(int id, int level) : super(id, "Multiple Choice", level) {
    exam = createExam(10, 0);
    result = [-1];
  }

  List<int> createExam(int domain, int before) {
    int x = 0;
    while (x == 0 || x == before) {
      x = random(domain);
    }
    int a = x;
    int b = random(1) == 0 ? a - 1 : a + 1;
    int c = b == a - 1 ? a + 1 : a - 1;
    b = b == 0 ? 3 : b;
    c = c == 0 ? 3 : c;
    b = b == domain ? domain - 3 : b;
    c = c == domain ? domain - 3 : c;

    List<int> result = [x];
    switch (random(3)) {
      case 0:
        {
          result.add(a);
          result.add(b);
          result.add(c);
          break;
        }
      case 1:
        {
          result.add(b);
          result.add(c);
          result.add(a);
          break;
        }
      case 2:
        {
          result.add(c);
          result.add(a);
          result.add(b);
          break;
        }
    }

    return result;
  }
}
