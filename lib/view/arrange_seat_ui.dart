// ignore_for_file: unnecessary_this
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toancungbe/model/arrange_seat.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/home_page.dart';
import 'package:toancungbe/model/game_model.dart';
import 'game_page.dart';

class ArrangeSeatUI extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ArrangeSeatUI(this.game);
  final Game game;

  @override
  // ignore: no_logic_in_create_state
  _ArrangeSeatUIState createState() => _ArrangeSeatUIState(game);
}

class _ArrangeSeatUIState extends State<ArrangeSeatUI> {
  final Game game;
  _ArrangeSeatUIState(this.game) {
    this._arrangeSeat.exam = this._arrangeSeat.createExam(10, 4);
    this._arrangeSeat.result = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    _seconds = this._arrangeSeat.level == 0 ? 30 : 15;
  }
  late final ArrangeSeat _arrangeSeat =
      ArrangeSeat(game.id, game.type, game.level);

  var _calcu = '<';
  var _img = [0, 0, 0, 0];
  List<bool> _moved = [true, true, true, true];
  List<String> _number = ['', '', '', ''];

  var _sectionTime = 0, _seconds = 5, _index = 1;
  double _hei = 8, _wid = 0;

  void _createTime() {
    _hei = 8;
    _wid = 0;
    _seconds = 0;
    _sectionTime = 0;
  }

  void _newGame() {
    if (this._arrangeSeat.level == 1) {
      int k = random(2);
      _calcu = k == 0 ? '<' : '>';
    }
    _arrangeSeat.exam = _arrangeSeat.createExam(10, 4);
    _img = [0, 0, 0, 0];
    _moved = [true, true, true, true];
    _number = ['', '', '', ''];
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
          if (_index <= 10) {
            _sectionTime = 1;
            _hei = 8;
            _wid = 32;
            _seconds = this._arrangeSeat.level == 0 ? 30 : 15;
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
          Duration(seconds: this._arrangeSeat.level == 0 ? 30 : 15), (timer) {
        timer.cancel();
        setState(() {
          _sectionTime = -1;
          _arrangeSeat.result[_index - 1] = 0;
          _index++;
          _arrangeSeat.result.add(-1);
          if (this._index > 10) {
            var rs = _arrangeSeat.total(_arrangeSeat.result);
            _showTotal(rs);
          } else {
            _newGame();
            _createTime();
            audioClick.click("audio/false.mp3");
          }
        });
      });
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bus/street.jpg'),
            fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(context, timeUI(context, _hei, _wid, _seconds),
              this._arrangeSeat),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(children: [
      Container(
        height: Responsive.height(80, context),
        width: Responsive.width(98, context),
        alignment: Alignment.topRight,
        //color: Colors.pink,
        child: Container(
          height: Responsive.height(70, context),
          width: Responsive.width(75, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                  image: AssetImage('assets/images/bus/bus.png'),
                  fit: BoxFit.fill)),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Responsive.height(84, context),
            width: Responsive.width(45, context),
            //color: Colors.pink,
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                _dragg(context, _arrangeSeat.exam[0], 1, _moved[0]),
                SizedBox(
                  width: Responsive.width(2, context),
                ),
                _dragg(context, _arrangeSeat.exam[1], 2, _moved[1]),
                SizedBox(
                  width: Responsive.width(2, context),
                ),
                _dragg(context, _arrangeSeat.exam[2], 3, _moved[2]),
                SizedBox(
                  width: Responsive.width(2, context),
                ),
                _dragg(context, _arrangeSeat.exam[3], 4, _moved[3]),
                SizedBox(
                  width: Responsive.width(2, context),
                ),
              ],
            ),
          ),
          Column(children: [
            Container(
              height: Responsive.height(25, context),
              width: Responsive.width(50, context),
              alignment: Alignment.topRight,
              //color: Colors.pink,
              child: Row(
                children: [
                  SizedBox(
                    width: Responsive.width(4, context),
                  ),
                  _dragT(context, 0),
                  SizedBox(
                    width: Responsive.width(0.8, context),
                  ),
                  _dragT(context, 1),
                  SizedBox(
                    width: Responsive.width(0.8, context),
                  ),
                  _dragT(context, 2),
                  SizedBox(
                    width: Responsive.width(0.8, context),
                  ),
                  _dragT(context, 3),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.height(4, context),
            ),
            Container(
              height: Responsive.height(14, context),
              width: Responsive.width(42, context),
              alignment: Alignment.topCenter,
              //color: Colors.black,
              child: _calculation(context),
            ),
            SizedBox(
              height: Responsive.height(10, context),
              width: Responsive.width(40, context),
              //color: Colors.black,
              child: Row(
                children: next(context, this._arrangeSeat.result, 0),
              ),
            ),
            Container(
              height: Responsive.height(20, context),
              width: Responsive.width(40, context),
              alignment: Alignment.bottomLeft,
              //color: Colors.blue,
              child: InkWell(
                onTap: () {
                  List<int> us = [];
                  try {
                    for (int i = 0; i < this._number.length; i++) {
                      us.add(int.parse(this._number[i]));
                    }
                  } catch (exception) {
                    return;
                  }
                  List<int> rs = this._arrangeSeat.exam;
                  if (this._calcu == '<') {
                    this._arrangeSeat.bubbleSort(rs, 0);
                  } else {
                    this._arrangeSeat.bubbleSort(rs, 1);
                  }

                  bool f = true;
                  for (int i = 0; i < rs.length; i++) {
                    if (us[i] != rs[i]) {
                      f = false;
                      break;
                    }
                  }
                  if (f) {
                    this._arrangeSeat.result[this._index - 1] = 1;
                    _index++;
                    if (_index < 10) audioClick.click("audio/true.mp3");
                  } else {
                    this._arrangeSeat.result[this._index - 1] = 0;
                    _index++;
                    if (_index < 10) audioClick.click("audio/false.mp3");
                  }
                  this._arrangeSeat.result.add(-1);
                  setState(() {
                    time.cancel();
                    _sectionTime = -1;
                    if (this._index > 10) {
                      var toto =
                          this._arrangeSeat.total(this._arrangeSeat.result);
                      _showTotal(toto);
                    } else {
                      _createTime();
                      this._newGame();
                    }
                  });
                },
                child: Container(
                  height: Responsive.height(15, context),
                  width: Responsive.width(20, context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green[400],
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Text('Khởi hành',
                      style: TextStyle(
                        color: Colors.red[800],
                        fontFamily: "Times New Roman",
                        fontSize: Responsive.height(6, context),
                        fontWeight: FontWeight.w900,
                      )),
                ),
              ),
            )
          ]),
        ],
      ),
    ]);
  }

  Widget _dragg(BuildContext context, int value, int imgValue, bool flag) {
    SizedBox _stu = SizedBox(
      height: Responsive.height(50, context),
      width: Responsive.width(9, context),
      //color: Colors.black,
      child: Column(
        children: [
          ClipOval(
            child: Container(
              height: Responsive.height(15, context),
              width: Responsive.height(15, context),
              color: Colors.blue[100],
              alignment: Alignment.center,
              child: Text('$value',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontFamily: "Times New Roman",
                    fontSize: Responsive.height(10, context),
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.none,
                  )),
            ),
          ),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          Container(
              height: Responsive.height(30, context),
              width: Responsive.width(9, context),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bus/stu$imgValue.png'),
                    fit: BoxFit.fill),
              )),
        ],
      ),
    );
    SizedBox _empty = SizedBox(
      height: Responsive.height(50, context),
      width: Responsive.width(9, context),
    );
    return Draggable(
        childWhenDragging: _empty,
        feedback: _stu,
        data: [value, imgValue],
        child: flag ? _stu : _empty);
  }

  Widget _dragT(BuildContext context, int locaCh) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: Responsive.height(24, context),
          width: Responsive.width(10, context),
          //color: Colors.black,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image:
                      AssetImage('assets/images/bus/chair${_img[locaCh]}.jpg'),
                  fit: BoxFit.fill)),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        int value = int.parse(data.toString().substring(1, 2));
        int imgValue = int.parse(data.toString().substring(4, 5));
        setState(() {
          _sectionTime = -1;
          if (this._number[locaCh] == '') {
            this._number[locaCh] = value.toString();
            this._img[locaCh] = imgValue;
            this._moved[imgValue - 1] = false;
            audioClick.click("audio/post.mp3");
          }
        });
      },
    );
  }

  Widget _calculation(BuildContext context) {
    Text _cal = Text(this._calcu,
        style: TextStyle(
          color: Colors.blue[800],
          fontFamily: "Times New Roman",
          fontSize: Responsive.height(10, context),
          fontWeight: FontWeight.w900,
        ));
    SizedBox _sb = SizedBox(
      width: Responsive.width(1, context),
    );
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      Widget _num = Container(
        height: Responsive.height(12, context),
        width: Responsive.width(6, context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.blue[100]),
        child: InkWell(
          onTap: () {
            setState(() {
              _sectionTime = -1;
              try {
                audioClick.click("audio/pop.mp3");
                int n = int.parse(this._number[i]);
                int k = 0;
                for (int i = 0; i < this._arrangeSeat.exam.length; i++) {
                  if (this._arrangeSeat.exam[i] == n) {
                    k = i;
                    break;
                  }
                }
                this._number[i] = '';
                this._img[i] = 0;
                this._moved[k] = true;
              } catch (ex) {
                return;
              }
            });
          },
          child: Container(
            height: Responsive.height(12, context),
            width: Responsive.width(6, context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue[100]),
            child: Text(this._number[i],
                style: TextStyle(
                  color: Colors.blue[800],
                  fontFamily: "Times New Roman",
                  fontSize: Responsive.height(7, context),
                  fontWeight: FontWeight.w900,
                )),
          ),
        ),
      );
      _children.add(_num);
      if (i < 3) {
        _children.add(_sb);
        _children.add(_cal);
        _children.add(_sb);
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: _children);
  }

  void _showTotal(List<int> rs) {
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
                                      this._arrangeSeat.result = [
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
                                      _index = 1;
                                      _newGame();
                                      _createTime();
                                      audioClick.click("audio/button.wav");
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
