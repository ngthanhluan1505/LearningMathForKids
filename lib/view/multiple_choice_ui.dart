// ignore_for_file: unnecessary_this
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toancungbe/model/multiple_choice.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/home_page.dart';
import 'package:toancungbe/model/game_model.dart';
import 'game_page.dart';

class MultipleChoiceUI extends StatefulWidget {
  final Game game;
  // ignore: use_key_in_widget_constructors
  const MultipleChoiceUI(this.game);
  @override
  // ignore: no_logic_in_create_state
  _MultipleChoiceUIState createState() => _MultipleChoiceUIState(game);
}

class _MultipleChoiceUIState extends State<MultipleChoiceUI> {
  final Game game;
  _MultipleChoiceUIState(this.game) {
    _seconds = _multipleChoice.level == 0 ? 10 : 5;
    _multipleChoice.result = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
  }

  late final MultipleChoice _multipleChoice =
      MultipleChoice(game.id, game.level);

  var _index = 0;

  var _sectionTime = 0, _seconds = 5;
  double _hei = 8, _wid = 0;

  void _createTime() {
    _hei = 8;
    _wid = 0;
    _seconds = 0;
    _sectionTime = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sectionTime == 0) {
      time = Timer.periodic(const Duration(seconds: 0), (timer) {
        timer.cancel();
        setState(() {
          if (_index < 10) {
            _sectionTime = 1;
            _hei = 8;
            _wid = 32;
            _seconds = _multipleChoice.level == 0 ? 10 : 5;
          } else {
            _sectionTime = 1;
            _hei = 8;
            _wid = 32;
            _seconds = 0;
          }
        });
      });
    }

    if (_sectionTime == 1) {
      time = Timer.periodic(
          Duration(seconds: _multipleChoice.level == 0 ? 10 : 5), (timer) {
        timer.cancel();
        setState(() {
          _createTime();
          _multipleChoice.exam =
              _multipleChoice.createExam(10, _multipleChoice.exam[0]);
          _multipleChoice.result[_index] = 0;
          _index++;
          if (_index + 1 > 10) {
            var rs = _multipleChoice.total(_multipleChoice.result);
            _showToTal(rs);
          } else {
            audioClick.click("audio/false.mp3");
          }
        });
      });
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/tnbrd.jpg'), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(
              context, timeUI(context, _hei, _wid, _seconds), _multipleChoice),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      height: Responsive.height(80, context),
      width: Responsive.width(80, context),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/tnbr.jpg'), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Container(
            height: Responsive.height(50, context),
            width: Responsive.width(70, context),
            padding: const EdgeInsets.all(10),
            child: _avatar(context, _multipleChoice.exam[0]),
          ),
          SizedBox(
            height: Responsive.height(30, context),
            width: Responsive.width(80, context),
            child: Row(
              children: [
                Container(
                  height: Responsive.height(20, context),
                  width: Responsive.width(30, context),
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Row(
                    children: next(context, _multipleChoice.result, 0),
                  ),
                ),
                Row(
                  children: [
                    _choice(context, _multipleChoice.exam[1]),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    _choice(context, _multipleChoice.exam[2]),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    _choice(context, _multipleChoice.exam[3]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _avatar(BuildContext context, int data) {
    List<String> image = ['bird', 'cat', 'chicken', 'dog', 'duck', 'pig'];
    List<Container> list = [];
    var rd = random(6);
    for (int i = 0; i < data; i++) {
      var contaier = Container(
        height: Responsive.height(3, context),
        width: Responsive.height(3, context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/animal/${image[rd]}.png'),
              fit: BoxFit.fill),
        ),
        child: InkWell(
          onTap: () {
            audioClick.click("audio/numbers/${i + 1}.wav");
            //playSortAudio("audio/numbers/${i + 1}.wav", 1, 0);
            // playSortAudio("audio/button.wav", 1, 0);
            //print('objecttttttttttttttttttttttttttttttttttttt'); // am thanh
          },
        ),
      );
      list.add(contaier);
    }
    return GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: Responsive.width(5, context),
      mainAxisSpacing: Responsive.height(3, context),
      children: list,
    );
  }

  Widget _choice(BuildContext context, int data) {
    return ClipOval(
      child: Container(
        height: Responsive.height(30, context),
        width: Responsive.height(30, context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/numbers/$data.jpg'),
              fit: BoxFit.fill),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              time.cancel();
              _createTime();
              if (data == _multipleChoice.exam[0]) {
                _multipleChoice.exam =
                    _multipleChoice.createExam(10, _multipleChoice.exam[0]);
                _multipleChoice.result[_index] = 1;
                audioClick.click("audio/true.mp3");
              } else {
                _multipleChoice.exam =
                    _multipleChoice.createExam(10, _multipleChoice.exam[0]);
                _multipleChoice.result[_index] = 0;
                audioClick.click("audio/false.mp3");
              }
              _index++;
              if (_index + 1 > 10) {
                var rs = _multipleChoice.total(_multipleChoice.result);
                _showToTal(rs);
              }
            });
          },
        ),
      ),
    );
  }

  void _showToTal(List<int> rs) {
    _sectionTime = -1;
    if (rs[0] == 0) {
      audioTotal.click("audio/lose.mp3");
    } else {
      audioTotal.click("audio/win.mp3");
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: Responsive.height(75, context),
              width: Responsive.width(70, context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: rs[0] == 0 ? Colors.deepPurple : Colors.blue[300],
                  borderRadius: BorderRadius.circular(20)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: Responsive.height(15, context),
                  width: Responsive.width(70, context),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Text(
                      rs[0] == 0
                          ? 'Tiếc quá! Thử lại nào!'
                          : 'Thắng rồi! Bé học giỏi lắm!',
                      style: TextStyle(
                        color: rs[0] == 0 ? Colors.red : Colors.green,
                        fontFamily: "Times New Roman",
                        fontSize: Responsive.height(7, context),
                        fontWeight: FontWeight.w900,
                      )),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    Container(
                      height: Responsive.height(60, context),
                      width: Responsive.width(30, context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: rs[0] == 0
                                  ? const AssetImage('assets/images/lose.gif')
                                  : const AssetImage('assets/images/win.gif'),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    SizedBox(
                      height: Responsive.height(60, context),
                      width: Responsive.width(30, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 80,
                              ),
                              Text(
                                ': +${rs[0]}',
                                style: TextStyle(
                                    color: rs[0] == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 40),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/candy.jpg',
                                        ),
                                        fit: BoxFit.fill)),
                              ),
                              Text(
                                ': +${rs[1]}',
                                style: TextStyle(
                                    color: rs[0] == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 40),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Responsive.height(2, context),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                color: Colors.amber[200],
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _multipleChoice.result = [
                                        -1,
                                        -1,
                                        -1,
                                        -1,
                                        -1,
                                        -1,
                                        -1,
                                        -1,
                                        -1,
                                        -1
                                      ];
                                      audioClick.click("audio/button.wav");
                                      _index = 0;
                                      _createTime();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: Responsive.height(12, context),
                                    width: Responsive.width(12, context),
                                    child: Icon(
                                      Icons.restart_alt_rounded,
                                      size: Responsive.height(10, context),
                                      color: Colors.green[800],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              Card(
                                color: Colors.amber[200],
                                child: InkWell(
                                  onTap: () {
                                    audioBackround.dispose();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                    audioBackround.init();
                                    audioBackround.playAudio(
                                        'audio/start.mp3', 1);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: Responsive.height(12, context),
                                    width: Responsive.width(12, context),
                                    child: Icon(
                                      Icons.house_rounded,
                                      color: Colors.green[800],
                                      size: Responsive.height(10, context),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ]),
            ),
          );
        });
  }
}
