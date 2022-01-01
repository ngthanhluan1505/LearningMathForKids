// ignore_for_file: unnecessary_this
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toancungbe/model/picking_fruit.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/home_page.dart';
import 'package:toancungbe/model/game_model.dart';
import 'game_page.dart';

class PickingFruitUI extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const PickingFruitUI(this.game);
  final Game game;
  @override
  // ignore: no_logic_in_create_state
  _PickingFruitUIState createState() => _PickingFruitUIState(game);
}

class _PickingFruitUIState extends State<PickingFruitUI> {
  final Game game;
  late final PickingFruit _pickingFruit =
      PickingFruit(game.id, game.type, game.level);
  _PickingFruitUIState(this.game) {
    this._pickingFruit.exam = this._pickingFruit.createExam(10, 10);
    this._pickingFruit.result = [];
    _seconds = _pickingFruit.level == 0 ? 60 : 30;
  }
  late final List<int> _data = [0, 0, 0];
  late int x, y, z;
  late var _img1 = 0;
  late var _img2 = 0;
  // ignore: non_constant_identifier_names
  late int _start_x = 0,
      // ignore: non_constant_identifier_names
      _start_y = 4,
      // ignore: non_constant_identifier_names
      _start_z = 7,
      // ignore: non_constant_identifier_names
      _end_x = 4,
      // ignore: non_constant_identifier_names
      _end_y = 7,
      // ignore: non_constant_identifier_names
      _end_z = 10;

  void _newGame() {
    _createTime();
    _start_x = 0;
    _start_y = 4;
    _start_z = 7;
    _end_x = 4;
    _end_y = 7;
    _end_z = 10;
    this._pickingFruit.exam = this._pickingFruit.createExam(10, 10);
    this._pickingFruit.result = [];
    _img1 = 0;
    _img2 = 0;
    _sectionTime = 0;
  }

  var _sectionTime = 0, _seconds = 5;
  double _hei = 8, _wid = 0;

  void _createTime() {
    _hei = 8;
    _wid = 0;
    _seconds = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    x = this._pickingFruit.exam[_start_x];
    y = this._pickingFruit.exam[_start_y];
    try {
      z = this._pickingFruit.exam[_start_z];
    } catch (ex) {
      z = 10;
    }

    if (_sectionTime == 0) {
      time = Timer.periodic(const Duration(seconds: 0), (timer) {
        timer.cancel();
        setState(() {
          _sectionTime = 1;
          _hei = 8;
          _wid = 32;
          _seconds = _pickingFruit.level == 0 ? 60 : 30;
        });
      });
    }

    if (_sectionTime == 1) {
      _sectionTime = -1;
      time = Timer.periodic(
          Duration(seconds: _seconds = _pickingFruit.level == 0 ? 60 : 30),
          (timer) {
        timer.cancel();
        setState(() {
          _createTime();
          if (this._pickingFruit.result.length < 10) {
            for (int i = _pickingFruit.result.length; i < 10; i++) {
              this._pickingFruit.result.add(0);
            }
          }
          _showTotal(_pickingFruit.total(this._pickingFruit.result));
        });
      });
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/plant/tree.png'),
            fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(context, timeUI(context, _hei, _wid, _seconds),
              this._pickingFruit),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: Responsive.width(100, context),
      height: Responsive.height(85, context),
      //color: Colors.amber,
      child: Row(
        children: [
          _fruit(context),
          _bag(context),
        ],
      ),
    );
  }

  Widget _drag(BuildContext context, int value, int flag) {
    Widget _container = Container();
    bool f = true;
    switch (flag) {
      case 0:
        {
          if (_start_x != _end_x) {
            _data[0] = value;
          } else {
            f = false;
          }
          break;
        }
      case 1:
        {
          if (_start_y != _end_y) {
            _data[1] = value;
          } else {
            f = false;
          }
          break;
        }
      case 2:
        {
          if (_start_z != _end_z) {
            _data[2] = value;
          } else {
            f = false;
          }
          break;
        }
    }
    if (f) {
      _container = Container(
          height: Responsive.height(25, context),
          width: Responsive.width(9, context),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/plant/or.png'),
                  fit: BoxFit.fill)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              '$value',
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'Arial',
                  color: Colors.black),
            ),
          ]));
    } else {
      _container = SizedBox(
        height: Responsive.height(25, context),
        width: Responsive.width(9, context),
      );
    }
    return Draggable(
        childWhenDragging: SizedBox(
          height: Responsive.height(25, context),
          width: Responsive.width(9, context),
        ),
        feedback: _container,
        data: flag,
        child: _container);
  }

  Widget _fruit(BuildContext context) {
    Row _row = Row(
      children: [
        SizedBox(
          width: Responsive.width(10, context),
        ),
        _drag(context, x, 0),
        SizedBox(
          width: Responsive.width(10, context),
        ),
        _drag(context, y, 1),
        SizedBox(
          width: Responsive.width(6, context),
        ),
        _drag(context, z, 2),
      ],
    );
    return SizedBox(
      width: Responsive.width(55, context),
      height: Responsive.height(85, context),
      //color: Colors.amber,
      child: _row,
    );
  }

  Widget _dragT(BuildContext context, int flag) {
    return DragTarget(builder: (context, candidateData, rejectedData) {
      return Container(
        height: Responsive.height(40, context),
        width: Responsive.width(20, context),
        decoration: BoxDecoration(
            //color: Colors.amber,
            image: DecorationImage(
                image: flag == 0
                    ? AssetImage('assets/images/plant/or$_img1.png')
                    : AssetImage('assets/images/plant/or$_img2.png'),
                fit: BoxFit.fill)),
      );
    }, onWillAccept: (data) {
      return true;
    }, onAccept: (data) {
      int loca = int.parse(data.toString());
      int value = _data[loca];
      setState(() {
        if (flag == 0) {
          if (this._pickingFruit.checkOddEven(value) == 0) {
            _img1++;
            this._pickingFruit.result.add(1);
            if (_pickingFruit.result.length < 10) {
              audioClick.click("audio/true.mp3");
            }
            if (this._pickingFruit.result.length == 10) {
              _showTotal(this._pickingFruit.total(this._pickingFruit.result));
            }
            switch (loca) {
              case 0:
                {
                  if (_start_x < _end_x) _start_x++;
                  break;
                }
              case 1:
                {
                  if (_start_y < _end_y) _start_y++;
                  break;
                }
              case 2:
                {
                  if (_start_z < _end_z) _start_z++;
                  break;
                }
            }
          }
        } else {
          if (this._pickingFruit.checkOddEven(value) == 1) {
            _img2++;
            this._pickingFruit.result.add(1);
            if (_pickingFruit.result.length < 10) {
              audioClick.click("audio/true.mp3");
            }
            if (this._pickingFruit.result.length == 10) {
              _showTotal(_pickingFruit.total(this._pickingFruit.result));
            }
            switch (loca) {
              case 0:
                {
                  if (_start_x < _end_x) _start_x++;
                  break;
                }
              case 1:
                {
                  if (_start_y < _end_y) _start_y++;
                  break;
                }
              case 2:
                {
                  if (_start_z < _end_z) _start_z++;
                  break;
                }
            }
          }
        }
      });
    });
  }

  Widget _bag(BuildContext context) {
    Column _column = Column(
      children: [
        SizedBox(
          height: Responsive.height(1, context),
        ),
        _dragT(context, 0),
        _dragT(context, 1)
      ],
    );
    return SizedBox(
      width: Responsive.width(34, context),
      height: Responsive.height(85, context),
      //color: Colors.amber,
      child: _column,
    );
  }

  void _showTotal(List<int> rs) {
    time.cancel();
    _sectionTime = -1;
    _createTime();
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
                                      rs.clear();
                                      _newGame();
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
  }
}
