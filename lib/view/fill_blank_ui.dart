// ignore_for_file: unnecessary_this, prefer_typing_uninitialized_variables
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toancungbe/model/fill_blank.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/home_page.dart';
import 'package:toancungbe/model/game_model.dart';
import 'game_page.dart';

class FillBlankUI extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const FillBlankUI(this.game, this.caculation);
  final String caculation;
  final Game game;
  @override
  // ignore: no_logic_in_create_state
  _FillBlankUIState createState() => _FillBlankUIState(game, caculation);
}

class _FillBlankUIState extends State<FillBlankUI> {
  _FillBlankUIState(this.game, this.caculation) {
    if (this.caculation == '+') {
      this._newGame1(0, 0);
    } //this._fillBlank.exam = [3, 2, 1, 2];
    if (this.caculation == '-') {
      this._newGame2(0, 0);
    } //this._fillBlank.exam = [2, 2, 4, 2];
    this._fillBlank.result = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    rd = random(6);
    _img = 'assets/images/animal/${image[rd]}.png';
    _seconds = _fillBlank.level == 0 ? 15 : 10;
  }
  final Game game;
  final String caculation;
  late final FillBlank _fillBlank = FillBlank(game.id, game.type, game.level);
  var bef = 0;
  var answ = '?';
  var st = false;
  var _index = 0;
  List<String> image = ['bird', 'cat', 'chicken', 'dog', 'duck', 'pig'];
  var rd = 0;
  var _img = '';

  var _sectionTime = 0, _seconds = 5;
  double _hei = 8, _wid = 0;

  void _createTime() {
    _hei = 8;
    _wid = 0;
    _seconds = 0;
    _sectionTime = 0;
  }

  void _newGame1(int bef1, int bef2) {
    rd = random(6);
    _img = 'assets/images/animal/${image[rd]}.png';
    if (_fillBlank.level == 0) {
      var lef = random(5);
      while (lef == bef1) {
        lef = random(5);
      }
      lef = lef == 0 ? 2 : lef;
      var rig = random(5);
      while (rig == bef2 || rig + lef > 9) {
        rig = random(5);
      }
      rig = rig == 0 ? 3 : rig;
      _fillBlank.exam = _fillBlank.createExam(2, lef, rig, caculation);
    } else {
      do {
        var loca = random(3);
        var rig = random(6);
        while (rig == bef2) {
          rig = random(6);
        }
        rig = rig <= 1 ? 5 : rig;
        rig = loca == 1 ? rig + 4 : rig;
        var lef = random(5);
        while (lef == bef1) {
          lef = random(5);
        }
        lef = lef >= rig ? rig - 1 : lef;
        lef = lef == 0 ? 1 : lef;
        _fillBlank.exam = _fillBlank.createExam(loca, lef, rig, caculation);
      } while (_fillBlank.exam[0] < 0);
    }
  }

  void _newGame2(int bef1, int bef2) {
    rd = random(6);
    _img = 'assets/images/animal/${image[rd]}.png';
    if (_fillBlank.level == 0) {
      var rig, lef;
      do {
        rig = random(5);
      } while (rig == bef2 || rig == 0);

      do {
        lef = random(8) + rig;
      } while (lef == bef1 || lef > 9);
      lef = lef == rig ? rig + 1 : lef;
      _fillBlank.exam = _fillBlank.createExam(2, lef, rig, caculation);
      if (_fillBlank.exam[0] > 5) _newGame2(bef1, bef2);
    } else {
      do {
        var loca = random(3);
        var rig, lef;
        do {
          rig = random(9);
        } while (rig == bef2 || rig == 0);

        do {
          lef = random(10);
        } while (lef == bef1 || lef == rig);

        _fillBlank.exam = _fillBlank.createExam(loca, lef, rig, caculation);
      } while (_fillBlank.exam[0] <= 0 || _fillBlank.exam[0] > 9);
    }
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
            _seconds = _fillBlank.level == 0 ? 15 : 10;
          } else {
            _sectionTime = -1;
            _hei = 8;
            _wid = 32;
            _seconds = 0;
          }
        });
      });
    }

    if (_sectionTime == 1) {
      time = Timer.periodic(
          Duration(seconds: _seconds = _fillBlank.level == 0 ? 15 : 10),
          (timer) {
        timer.cancel();
        _sectionTime = -1;
        setState(() {
          _createTime();
          answ = answ == '?' ? '-1' : answ;
          try {
            if (int.parse(answ) == _fillBlank.exam[0]) {
              if (caculation == '+') {
                _newGame1(_fillBlank.exam[2], _fillBlank.exam[3]);
              } else {
                _newGame2(_fillBlank.exam[2], _fillBlank.exam[3]);
              }
              _fillBlank.result[_index] = 1;
              if (_index + 1 <= 10) audioClick.click("audio/true.mp3");
            } else {
              if (caculation == '+') {
                _newGame1(_fillBlank.exam[2], _fillBlank.exam[3]);
              } else {
                _newGame2(_fillBlank.exam[2], _fillBlank.exam[3]);
              }
              _fillBlank.result[_index] = 0;
              if (_index + 1 <= 10) audioClick.click("audio/false.mp3");
            }
          } catch (e) {
            if (caculation == '+') {
              _newGame1(_fillBlank.exam[2], _fillBlank.exam[3]);
            } else {
              _newGame2(_fillBlank.exam[2], _fillBlank.exam[3]);
            }
            _fillBlank.result[_index] = 0;
            if (_index + 1 <= 10) audioClick.click("audio/false.mp3");
          }
          _index++;
          answ = '?';
          if (_index + 1 > 10) {
            var rs = _fillBlank.total(_fillBlank.result);
            _showTotal(rs);
          }
        });
      });
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/gbr1.jpg'), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(
              context, timeUI(context, _hei, _wid, _seconds), this._fillBlank),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: Responsive.width(100, context),
      height: Responsive.height(85, context),
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: next(context, _fillBlank.result, 1)),
          SizedBox(
            width: Responsive.width(1, context),
          ),
          caculation == '+' ? _avatarPlus(context) : _avatarMinus(context),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          SizedBox(
            width: Responsive.width(2, context),
          ),
          _keyboard(context),
        ],
      ),
    );
  }

  Widget _avatarPlus(BuildContext context) {
    var _ex = this._fillBlank.exam;
    return this._fillBlank.level == 0
        ? Container(
            height: Responsive.height(80, context),
            width: Responsive.width(55, context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 1)),
            child: Column(
              children: [
                SizedBox(
                  height: Responsive.height(5, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      _animalLeft(context, _ex[1] == 0 ? _ex[0] : _ex[2], 1),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Text(
                  this.caculation,
                  style: const TextStyle(fontSize: 30, color: Colors.black),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _animalLeft(
                      context,
                      _ex[1] == 0
                          ? _ex[2]
                          : _ex[1] == 1
                              ? _ex[0]
                              : _ex[3],
                      2),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                const Text(
                  '____________________________',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                const Text(
                  '?',
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ],
            ))
        : Container();
  }

  List<Widget> _animalLeft(BuildContext context, int n, int sound) {
    SizedBox _sb = SizedBox(
      width: Responsive.width(2, context),
    );
    List<Widget> row = [];
    row.add(_sb);
    for (int i = 0; i < n; i++) {
      Container _container = Container(
          height: Responsive.height(15, context),
          width: Responsive.height(15, context),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(_img), fit: BoxFit.fill),
          ),
          child: InkWell(onTap: () {
            if (sound == 1) {
              audioClick.click("audio/numbers/${i + 1}.wav");
            }
            if (sound == 2) {
              audioClick
                  .click("audio/numbers/${i + 1 + _fillBlank.exam[2]}.wav");
            }
          }));
      row.add(_container);
      row.add(_sb);
    }
    return row;
  }

  List<Widget> _animalLeftMinus(BuildContext context, int n) {
    SizedBox _sb = SizedBox(
      width: Responsive.width(2, context),
    );
    List<Widget> row = [];
    row.add(_sb);
    for (int i = 0; i < n; i++) {
      Container _container = Container(
        height: Responsive.height(15, context),
        width: Responsive.height(15, context),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(_img), fit: BoxFit.fill),
        ),
      );
      Stack stack = Stack(
        children: [
          _container,
          Container(
              height: Responsive.height(15, context),
              width: Responsive.height(15, context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/animal/cut.png'),
                    fit: BoxFit.fill),
              ),
              child: InkWell(onTap: () {
                audioClick
                    .click("audio/numbers/${i + 1 + _fillBlank.exam[0]}.wav");
              })),
        ],
      );
      row.add(stack);
      row.add(_sb);
    }
    return row;
  }

  Widget _avatarMinus(BuildContext context) {
    var _ex = this._fillBlank.exam;
    return this._fillBlank.level == 0
        ? Container(
            height: Responsive.height(80, context),
            width: Responsive.width(55, context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _animalLeft(context, _ex[0], 1),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _animalLeftMinus(context, _ex[3]),
                ),
              ],
            ))
        : Container();
  }

  Widget _caculation(BuildContext context) {
    var ex = _fillBlank.exam;
    return Container(
      height: Responsive.height(14, context),
      width: Responsive.width(27, context),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(39), topRight: Radius.circular(39)),
          border: Border.all(color: Colors.black, width: 1)),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (ex[1] == 0 ? answ : '${ex[2]}') + ' ',
              style: TextStyle(
                  fontSize: 30,
                  color: ex[1] == 0 ? Colors.red[900] : Colors.black),
            ),
            Text(
              caculation + ' ',
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
            Text(
              (ex[1] == 0
                      ? '${ex[2]}'
                      : ex[1] == 1
                          ? answ
                          : '${ex[3]}') +
                  ' ',
              style: TextStyle(
                  fontSize: 30,
                  color: ex[1] == 1 ? Colors.red[900] : Colors.black),
            ),
            const Text(
              ('= '),
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            Text(
              (ex[1] == 2 ? answ : '${ex[3]}'),
              style: TextStyle(
                  fontSize: 30,
                  color: ex[1] == 2 ? Colors.red[900] : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _keyboard(BuildContext context) {
    List<Widget> kb1 = [];
    List<Widget> kb2 = [];
    List<Widget> kb3 = [];
    List<Widget> kb0 = [];
    var sb = const SizedBox(
      width: 10,
    );
    for (int i = -2; i <= 9; i++) {
      Widget it = ClipOval(
          child: Container(
        height: Responsive.height(15, context),
        width: Responsive.height(15, context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/numbers/$i.jpg'),
              fit: BoxFit.fill),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              _sectionTime = -1;
              if (i != -2 && i != 0) {
                audioClick.click("audio/phone.mp3");
                if (i == -1) {
                  answ = '0';
                } else {
                  answ = '$i';
                }
              } else {
                if (i == -2) {
                  answ = '?';
                  audioClick.click("audio/phone.mp3");
                } else {
                  try {
                    if (int.parse(answ) == _fillBlank.exam[0]) {
                      if (caculation == '+') {
                        _newGame1(_fillBlank.exam[2], _fillBlank.exam[3]);
                      } else {
                        _newGame2(_fillBlank.exam[2], _fillBlank.exam[3]);
                      }
                      _fillBlank.result[_index] = 1;
                      if (_index + 1 <= 10) audioClick.click("audio/true.mp3");
                    } else {
                      if (caculation == '+') {
                        _newGame1(_fillBlank.exam[2], _fillBlank.exam[3]);
                      } else {
                        _newGame2(_fillBlank.exam[2], _fillBlank.exam[3]);
                      }
                      _fillBlank.result[_index] = 0;
                      if (_index + 1 <= 10) audioClick.click("audio/false.mp3");
                    }
                    time.cancel();
                    _index++;
                    _createTime();
                  } catch (e) {
                    //........................................................
                  }
                  answ = '?';
                  if (_index + 1 > 10) {
                    var rs = _fillBlank.total(_fillBlank.result);
                    _showTotal(rs);
                  }
                }
              }
            });
          },
        ),
      ));
      if (i < 1) {
        kb0.add(it);
        kb0.add(sb);
      }
      if (i > 0 && i <= 3) {
        kb1.add(it);
        kb1.add(sb);
      }
      if (i > 3 && i <= 6) {
        kb2.add(it);
        kb2.add(sb);
      }
      if (i > 6 && i <= 9) {
        kb3.add(it);
        kb3.add(sb);
      }
    }
    return Container(
      height: Responsive.height(80, context),
      width: Responsive.width(27, context),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1)),
      child: Column(children: [
        _caculation(context),
        SizedBox(
          height: Responsive.height(1, context),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: kb1,
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
                children: kb2,
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
                children: kb3,
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
                children: kb0,
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _showTotal(List<int> rs) {
    _sectionTime = -1;
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
                                      _createTime();
                                      this._fillBlank.result = [
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
                                      _index = 0;
                                      Navigator.pop(context);
                                      audioClick.click("audio/button.wav");
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
    if (rs[0] == 0) {
      audioTotal.click("audio/lose.mp3");
    } else {
      audioTotal.click("audio/win.mp3");
    }
  }
}
