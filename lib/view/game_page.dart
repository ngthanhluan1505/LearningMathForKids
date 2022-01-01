import 'package:flutter/material.dart';
import 'package:toancungbe/view/arrange_seat_ui.dart';
import 'package:toancungbe/view/fill_blank_ui.dart';
import 'package:toancungbe/view/find_item_ui.dart';
import 'package:toancungbe/view/picking_fruit_ui.dart';
import 'package:toancungbe/model/game_model.dart';
import 'package:toancungbe/view/multiple_choice_ui.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view_models/list_data_vm.dart';

class GamePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GamePage(this.game);
  final Game game;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _GameUI(context, game), resizeToAvoidBottomInset: false);
  }

  // ignore: non_constant_identifier_names
  Widget _GameUI(BuildContext context, Game game) {
    audioBackround.init();
    switch (game.type) {
      case 'Multiple Choice':
        {
          audioBackround.playAudio('audio/game/hpkid.mp3', 1);
          return MultipleChoiceUI(game);
        }
      case 'Fill Blank+':
        {
          audioBackround.playAudio('audio/game/happy.m4a', 1);
          return FillBlankUI(game, '+');
        }
      case 'Fill Blank-':
        {
          audioBackround.playAudio('audio/game/bird.mp3', 1);
          return FillBlankUI(game, '-');
        }
      case 'Picking Fruit':
        {
          audioBackround.playAudio('audio/game/pac.mp3', 1);
          return PickingFruitUI(game);
        }
      case 'Arrange Seat':
        {
          audioBackround.playAudio('audio/game/car.mp3', 1);
          return ArrangeSeatUI(game);
        }
      case 'Find Item':
        {
          audioBackround.playAudio('audio/game/together.mp3', 1);
          return FindItemUI(game);
        }
      default:
        return Container();
    }
  }
}

List<Widget> next(BuildContext context, List<int> result, int flag) {
  List<Widget> list = [];
  SizedBox sb = flag == 0
      ? const SizedBox(
          width: 2,
        )
      : const SizedBox(
          height: 2,
        );
  for (int i = 0; i < result.length; i++) {
    var page = Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: result[i] == -1
              ? Colors.white
              : result[i] == 1
                  ? Colors.green
                  : Colors.red,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black, width: 1)),
    );
    if (i < 10) {
      list.add(page);
      list.add(sb);
    }
  }
  return list;
}

Widget header(BuildContext context, Widget timeUI, Game game) {
  return Container(
    height: Responsive.height(15, context),
    width: Responsive.width(100, context),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
            child: Material(
                color: Colors.red[900],
                child: InkWell(
                  child: Icon(Icons.arrow_left_rounded,
                      color: Colors.blue[200],
                      size: Responsive.height(10, context)),
                  onTap: () {
                    audioClick.click("audio/button.wav");
                    audioBackround.dispose();
                    time.cancel();
                    Navigator.pop(context);
                  },
                ))),
        SizedBox(
          width: Responsive.width(2, context),
        ),
        ClipOval(
            child: Material(
                color: Colors.red[900],
                child: InkWell(
                  child: Icon(Icons.help_outlined,
                      color: Colors.blue[200],
                      size: Responsive.height(10, context)),
                  onTap: () {
                    audioClick.click("audio/button.wav");
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: _dialogWidget(game));
                      },
                    );
                    //Navigator.pop(context);..............................
                  },
                ))),
        SizedBox(
          width: Responsive.width(15, context),
        ),
        timeUI,
        Icon(
          Icons.access_time_filled_rounded,
          color: Colors.deepPurple[700],
          size: Responsive.height(10, context),
        ),
        SizedBox(
          height: Responsive.height(20, context),
          width: Responsive.width(30, context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: Responsive.height(7, context),
                width: Responsive.width(8, context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1)),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: Responsive.width(1.46, context),
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: Responsive.height(5, context),
                    ),
                    Material(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Responsive.height(4, context)),
                      child: Text(
                        '${user.star}',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: Responsive.width(1, context),
              ),
              Container(
                height: Responsive.height(7, context),
                width: Responsive.width(8, context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1)),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: Responsive.width(1, context),
                    ),
                    Container(
                      height: Responsive.height(5, context),
                      width: Responsive.height(6, context),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/candy.jpg',
                              ),
                              fit: BoxFit.fill)),
                    ),
                    Material(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: Responsive.height(4, context)),
                      child: Text(
                        '${user.candy}',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget timeUI(BuildContext context, double hei, double wid, int seconds) {
  return Container(
      height: Responsive.height(8, context),
      width: Responsive.width(32, context),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
      child: AnimatedContainer(
        height: Responsive.height(hei, context),
        width: Responsive.width(wid, context),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1)),
        duration: Duration(seconds: seconds),
        curve: Curves.easeIn,
      ));
}

// ignore: camel_case_types
class _dialogWidget extends StatefulWidget {
  final Game game;
  const _dialogWidget(this.game);

  @override
  // ignore: no_logic_in_create_state
  _dialogWidgetState createState() => _dialogWidgetState(game);
}

// ignore: camel_case_types
class _dialogWidgetState extends State<_dialogWidget> {
  final Game game;
  _dialogWidgetState(this.game);
  var img = 'assets/images/eat.gif';
  late Widget _state;
  late int _flag;
  String _value = '?';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (game.id) {
      case 1:
      case 2:
      case 3:
        {
          _flag = 0;
          _state = Align(
            alignment: Alignment.center,
            child: Text(_value,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Times New Roman",
                  fontSize: user.candy > 0
                      ? Responsive.height(20, context)
                      : Responsive.height(10, context),
                  fontWeight: FontWeight.normal,
                )),
          );
          break;
        }
      case 4:
        {
          _flag = 1;
          _state = Align(
            alignment: Alignment.center,
            child: Text(_value,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Times New Roman",
                  fontSize: Responsive.height(7, context),
                  fontWeight: FontWeight.normal,
                )),
          );
          break;
        }
      case 5:
        {
          _flag = 2;
          _state = Align(
            alignment: Alignment.center,
            child: Text(_value,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Times New Roman",
                  fontSize: Responsive.height(10, context),
                  fontWeight: FontWeight.normal,
                )),
          );
          break;
        }
      case 6:
        {
          _state = Align(
            alignment: Alignment.center,
            child: Text(
              'Mình không giúp bạn được rồi!',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Times New Roman",
                fontSize: Responsive.height(8, context),
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          );
          break;
        }
    }
    return Container(
      height: Responsive.height(80, context),
      width: Responsive.width(70, context),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Responsive.height(10, context),
            width: Responsive.width(65, context),
            child: Row(
              children: [
                Container(
                  height: Responsive.height(10, context),
                  width: Responsive.width(40, context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.black),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Cho kẹo đi! Mình sẽ giúp bạn',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Times New Roman",
                          fontSize: Responsive.height(5, context),
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
                SizedBox(
                  width: Responsive.width(65 - 40, context) -
                      Responsive.height(10, context),
                ),
                InkWell(
                  onTap: () {
                    audioClick.click("audio/button.wav");
                    Navigator.pop(context);
                  },
                  child: ClipOval(
                    child: Container(
                      height: Responsive.height(10, context),
                      width: Responsive.height(10, context),
                      color: Colors.green,
                      child: Icon(
                        Icons.close,
                        color: Colors.red[700],
                        size: Responsive.height(8, context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Responsive.height(3, context),
          ),
          SizedBox(
            height: Responsive.height(60, context),
            width: Responsive.width(65, context),
            child: Row(
              children: [
                Container(
                  height: Responsive.height(50, context),
                  width: Responsive.width(23, context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.fill,
                  )),
                ),
                SizedBox(
                  width: Responsive.width(2, context),
                ),
                SizedBox(
                  height: Responsive.height(60, context),
                  width: Responsive.width(60 - 23, context),
                  //color: Colors.amber,
                  child: Column(
                    children: [
                      Container(
                        height: Responsive.height(45, context),
                        width: Responsive.width(60 - 23, context),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.black)),
                        child: _state,
                      ),
                      SizedBox(height: Responsive.height(2, context)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_flag == 0 && _value == '?') {
                              if (user.candy > 0) {
                                _value = game.exam[0].toString();
                                user.candy--;
                                user.writeCandy(user.candy.toString());
                              } else {
                                _value = 'Bạn đã hết kẹo!';
                              }
                            }

                            if (_flag == 1 && _value == '?') {
                              if (user.candy > 0) {
                                _value =
                                    'Số lẻ: 1, 3, 5, 7, 9 \nSố chẳn: 2, 4, 6, 8, 10';
                                user.candy--;
                                user.writeCandy(user.candy.toString());
                              } else {
                                _value = 'Bạn đã hết kẹo!';
                              }
                            }

                            if (_flag == 2 && _value == '?') {
                              if (user.candy > 0) {
                                var ex = copy(game.exam);
                                sort(ex, 0);
                                String s1 = '', s2 = '';
                                for (int i = 0; i < ex.length - 1; i++) {
                                  s1 += ' ${ex[i]} <';
                                }
                                s1 += ' ${ex[ex.length - 1]}';
                                sort(ex, 1);
                                for (int i = 0; i < ex.length - 1; i++) {
                                  s2 += ' ${ex[i]} >';
                                }
                                s2 += ' ${ex[ex.length - 1]}';
                                _value = '$s1 \n\n$s2';
                                user.candy--;
                                user.writeCandy(user.candy.toString());
                              } else {
                                _value = 'Bạn đã hết kẹo!';
                              }
                            }
                          });
                        },
                        child: Container(
                          height: Responsive.height(10, context),
                          width: Responsive.width(13, context),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: Responsive.height(8, context),
                                width: Responsive.height(9, context),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/candy.jpg',
                                        ),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: Responsive.width(1, context),
                              ),
                              Text('-1',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Responsive.height(8, context)))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
