// ignore_for_file: unnecessary_this
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toancungbe/model/find_item.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/home_page.dart';
import 'package:toancungbe/model/game_model.dart';
import 'game_page.dart';

class FindItemUI extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const FindItemUI(this.game);
  final Game game;
  @override
  // ignore: no_logic_in_create_state
  _FindItemUIState createState() => _FindItemUIState(game);
}

class _FindItemUIState extends State<FindItemUI> {
  final Game game;
  _FindItemUIState(this.game) {
    _findItem.result = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    _newGame();
    _seconds = _findItem.level == 0 ? 15 : 10;
  }
  late final FindItem _findItem = FindItem(game.id, game.type, game.level);
  var _boxIP = <bool>[false, false, false];
  late final List<int> _ng = [];
  var _exam = <int>[], _index = 0;

  var _sectionTime = 0, _seconds = 5;
  // ignore: unused_field
  double _hei = 8, _wid = 0;

  void _createTime() {
    _hei = 8;
    _wid = 0;
    _seconds = 0;
    _sectionTime = 0;
  }

  void _newGame() {
    int k;
    var mart = <int>[];
    for (int i = 0; i < 3; i++) {
      do {
        k = random(10);
      } while (inMart(mart, k));
      mart.add(k);
      _ng.add(k);
      _boxIP = <bool>[false, false, false];
      this._findItem.exam = this._findItem.createExam(10);
      _exam = copy(this._findItem.exam);
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
          if (_index + 1 <= 10) {
            _sectionTime = 1;
            _hei = 8;
            _wid = 32;
            _seconds = this._findItem.level == 0 ? 15 : 10;
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
          Duration(seconds: this._findItem.level == 0 ? 15 : 10), (timer) {
        timer.cancel();
        _sectionTime = -1;
        setState(() {
          _findItem.result[_index] = 0;
          _index++;
          if (_index + 1 > 10) {
            var rs = _findItem.total(_findItem.result);
            _showTotal(rs);
          } else {
            _createTime();
            _newGame();
            audioClick.click("audio/false.mp3");
          }
        });
      });
    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(
              context, timeUI(context, _hei, _wid, _seconds), this._findItem),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: Responsive.width(100, context),
      height: Responsive.height(85, context),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: Responsive.width(20, context),
              ),
              Container(
                width: Responsive.width(80, context),
                height: Responsive.height(85, context),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/classroom/br.jpg'),
                      fit: BoxFit.fill),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Responsive.width(80, context),
                height: Responsive.height(27, context),
                alignment: Alignment.centerLeft,
                //color: Colors.pink,
                child: Column(
                  children: [
                    _dragT(context),
                    SizedBox(
                      height: Responsive.height(10, context),
                      width: Responsive.width(75, context),
                      // color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: next(context, this._findItem.result, 0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Responsive.width(90, context),
                height: Responsive.height(46, context),
                alignment: Alignment.bottomRight,
                //color: Colors.pink,
                child: _dragg(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _dragT(BuildContext context) {
    var row = <Widget>[];
    SizedBox sb = SizedBox(
      width: Responsive.width(2, context),
    );
    String img1 = '', img2 = '';
    for (int i = 0; i < 3; i++) {
      int temp = this._exam[this._ng[i]];
      switch (temp) {
        case 0:
          {
            img1 = 'assets/images/classroom/brtron.png';
            img2 = 'assets/images/classroom/tron.png';
            break;
          }
        case 1:
          {
            img1 = 'assets/images/classroom/brvuong.png';
            img2 = 'assets/images/classroom/vuong.png';
            break;
          }
        case 2:
          {
            img1 = 'assets/images/classroom/brchunhat.png';
            img2 = 'assets/images/classroom/chunhat.png';
            break;
          }
        case 3:
          {
            img1 = 'assets/images/classroom/brtamgiac.png';
            img2 = 'assets/images/classroom/tamgiac.png';
            break;
          }
      }
      Widget boxDra = Stack(children: [
        Container(
          height: Responsive.width(7, context),
          width: Responsive.width(7, context),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(img1), fit: BoxFit.fill)),
        ),
        _boxDr(context, i, img1, img2)
      ]);
      row.add(boxDra);
      row.add(sb);
    }
    return Row(
      children: [
        Container(
          width: Responsive.width(32, context),
          height: Responsive.height(15, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue[200],
              border: Border.all(color: Colors.black, width: 1)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: row,
          ),
        ),
        SizedBox(
          width: Responsive.width(2, context),
        ),
        ClipOval(
          child: Container(
            width: Responsive.width(8, context),
            height: Responsive.height(15, context),
            color: Colors.green,
            child: InkWell(
              onTap: () {
                if (this._boxIP[0] && this._boxIP[1] && this._boxIP[2]) {
                  setState(() {
                    time.cancel();
                    _sectionTime = -1;
                    this._findItem.result[_index] = 1;
                    _index++;
                    if (_index + 1 > 10) {
                      _showTotal(this._findItem.total(this._findItem.result));
                    } else {
                      _newGame();
                      _createTime();
                      audioClick.click("audio/true.mp3");
                    }
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: Responsive.width(5, context),
                height: Responsive.height(15, context),
                child: Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.amber[200],
                  size: Responsive.height(15, context),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _boxDr(BuildContext context, int i, String img1, String img2) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) => Container(
        height: Responsive.width(7, context),
        width: Responsive.width(7, context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: _boxIP[i] ? AssetImage(img2) : AssetImage(img1),
              fit: BoxFit.fill),
        ),
      ),
      onWillAccept: (value) => true,
      onAccept: (value) {
        int flag = 0, position = 0;
        try {
          flag = int.parse(value.toString().substring(1, 2));
          position = int.parse(value.toString().substring(4, 5));
          // ignore: empty_catches
        } catch (ex) {}
        int a = this._exam[this._ng[i]];
        if (a == flag && this._boxIP[i] == false) {
          setState(() {
            _sectionTime = -1;
            this._boxIP[i] = true;
            this._findItem.exam[position] = -1;
            audioClick.click("audio/post.mp3");
          });
        }
      },
    );
  }

  Widget _dragg(BuildContext context) {
    return SizedBox(
      width: Responsive.width(57, context),
      height: Responsive.height(20, context),
      //color: Colors.amber
      child: Row(
        children: [
          _item(context, this._findItem.exam[0], 0),
          SizedBox(
            width: Responsive.width(2, context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  _item(context, this._findItem.exam[1], 1),
                  SizedBox(
                    width: Responsive.width(4, context),
                  ),
                  _item(context, this._findItem.exam[2], 2)
                ],
              ),
              _item(context, this._findItem.exam[3], 3),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: Responsive.width(4, context),
                  ),
                  _item(context, this._findItem.exam[4], 4),
                  SizedBox(
                    width: Responsive.width(2, context),
                  ),
                  _item(context, this._findItem.exam[5], 5),
                ],
              ),
              Row(
                children: [
                  _item(context, this._findItem.exam[6], 6),
                  SizedBox(
                    width: Responsive.width(3, context),
                  ),
                  _item(context, this._findItem.exam[7], 7),
                ],
              )
            ],
          ),
          SizedBox(
            width: Responsive.width(3, context),
          ),
          Column(
            children: [
              SizedBox(
                height: Responsive.height(5, context),
              ),
              Row(
                children: [
                  _item(context, this._findItem.exam[8], 8),
                  SizedBox(
                    width: Responsive.width(4, context),
                  ),
                  _item(context, this._findItem.exam[9], 9),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  //0: hình tròn, 1: hình vuông, 2: hình chữ nhật, 3: hình tam giác
  Widget _item(BuildContext context, int flag, int position) {
    String img = '';
    switch (flag) {
      case 0:
        {
          img = 'assets/images/classroom/tron.png';
          break;
        }
      case 1:
        {
          img = 'assets/images/classroom/vuong.png';
          break;
        }
      case 2:
        {
          img = 'assets/images/classroom/chunhat.png';
          break;
        }
      case 3:
        {
          img = 'assets/images/classroom/tamgiac.png';
          break;
        }
      case -1:
        img = 'assets/images/classroom/tamgiac.png';
        break;
    }
    SizedBox empty = SizedBox(
      height: Responsive.height(10, context),
      width: Responsive.height(10, context),
    );
    Container item = Container(
      width: Responsive.height(10, context),
      height: Responsive.height(10, context),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.fill),
      ),
    );
    var _data = [flag, position];
    return Draggable(
        childWhenDragging: empty,
        feedback: flag == -1 ? empty : item,
        data: _data,
        child: flag == -1 ? empty : item);
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
                                      this._findItem.result = [
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
                                      _newGame();
                                      audioClick.click("audio/button.wav");
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
