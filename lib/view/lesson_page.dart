// ignore_for_file: unnecessary_this

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toancungbe/model/lesson_model.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/game_page.dart';
import 'package:toancungbe/view/home_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonPage extends StatelessWidget {
  final Lesson _lesson;
  // ignore: use_key_in_widget_constructors
  const LessonPage(this._lesson);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: _lesson.key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        //hideControls: true,
      ),
    );
    return Scaffold(
        resizeToAvoidBottomInset: false, body: _Player(_controller, _lesson));
  }
}

class _Player extends StatefulWidget {
  const _Player(this._ct, this._lesson);
  final Lesson _lesson;
  final YoutubePlayerController _ct;
  @override
  // ignore: no_logic_in_create_state
  _PlayerState createState() => _PlayerState(this._ct, this._lesson);
}

class _PlayerState extends State<_Player> {
  final YoutubePlayerController _controller;
  final Lesson _lesson;
  late bool _st, _ft;
  late int _nofication;
  double _viewL = 100;
  var _open = 0;
  _PlayerState(this._controller, this._lesson) {
    _st = true;
    _nofication = 0;
    _ft = false;
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_nofication == 0) {
      time = Timer.periodic(const Duration(seconds: 3), (timer) {
        setState(() {
          _nofication = 1;
          _viewL = 0;
          _open = 1;
          final scaffold = Scaffold.of(context);
          // ignore: deprecated_member_use
          scaffold.showSnackBar(
            SnackBar(
              content: Text(this._lesson.name),
              action: SnackBarAction(
                  label: 'X',
                  // ignore: deprecated_member_use
                  onPressed: scaffold.hideCurrentSnackBar),
            ),
          );
          timer.cancel();
        });
      });
    }

    if (_ft) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
    }

    _controller.addListener(() {
      setState(() {
        if (_controller.value.isPlaying == false) {
          _st = false;
        } else {
          _st = true;
        }
        if (_controller.value.isFullScreen == true) {
          _ft = true;
        }
      });
    });

    return Stack(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: Responsive.width(85, context),
              height: Responsive.height(100, context),
              color: Colors.pink,
              child: YoutubePlayer(
                controller: _controller,
              ),
            ),
            _building(context)
          ]),
      _Slay(context)
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget _Slay(BuildContext context) {
    String img = '';
    switch (_lesson.id) {
      case 1:
        img = 'assets/images/lesson/le1.jpg';
        break;
      case 2:
        img = 'assets/images/lesson/le2.jpg';
        break;
      case 3:
        img = 'assets/images/lesson/le3.jpg';
        break;
      case 4:
        img = 'assets/images/lesson/le4.jpg';
        break;
      case 5:
        img = 'assets/images/lesson/le5.jpg';
        break;
      case 6:
        img = 'assets/images/lesson/le6.jpg';
        break;
    }
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.decelerate,
      width: Responsive.width(100, context),
      height: Responsive.height(_viewL, context),
      color: Colors.white,
      child: _open == 0
          ? Container(
              width: Responsive.width(100, context),
              height: Responsive.height(100, context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.fill)),
            )
          : Container(),
    );
  }

  Widget _building(BuildContext context) {
    return Container(
      height: Responsive.height(100, context),
      width: Responsive.width(100 - 85, context),
      color: Colors.pink[100],
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: Responsive.width(15, context),
              height: Responsive.height(25, context),
              child: ClipOval(
                child: Material(
                  color: Colors.green[900],
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          audioClick.click("audio/button.wav");
                          if (_st == true) {
                            _st = false;
                            _controller.pause();
                          } else {
                            _st = true;
                            _controller.play();
                          }
                        });
                      },
                      child: _st
                          ? Icon(Icons.pause_circle_filled_outlined,
                              color: Colors.amber[200],
                              size: Responsive.height(25, context))
                          : Icon(Icons.play_circle_fill_outlined,
                              color: Colors.amber[200],
                              size: Responsive.height(25, context))),
                ),
              ),
            ),
            SizedBox(
              height: Responsive.height(1.5, context),
            ),
            ClipOval(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.center,
                width: Responsive.height(25, context),
                height: Responsive.height(25, context),
                color: Colors.green[900],
                child: InkWell(
                  child: Icon(Icons.videogame_asset,
                      color: Colors.amber[200],
                      size: Responsive.height(20, context)),
                  onTap: () {
                    _controller.pause();
                    _gameLevel(context);
                    setState(() {
                      time.cancel();
                      _st = false;
                      audioClick.click("audio/button.wav");
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: Responsive.height(1.5, context),
            ),
            Container(
              padding: const EdgeInsets.all(0.0),
              alignment: Alignment.center,
              width: Responsive.width(15, context),
              height: Responsive.height(25, context),
              child: ClipOval(
                child: Material(
                  color: Colors.green[900],
                  child: InkWell(
                    child: Icon(Icons.chevron_left,
                        color: Colors.amber[200],
                        size: Responsive.height(25, context)),
                    onTap: () {
                      audioClick.click("audio/button.wav");
                      audioBackround.init();
                      time.cancel();
                      audioBackround.playAudio('audio/start.mp3', 1);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  bool _gameLevel(BuildContext context) {
    bool f = false;
    time.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: Responsive.height(90, context),
              width: Responsive.width(68, context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: Responsive.height(10, context),
                  width: Responsive.width(68, context),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Text('Luật chơi',
                      style: TextStyle(
                        color: Colors.purple,
                        fontFamily: "Times New Roman",
                        fontSize: Responsive.height(5, context),
                        fontWeight: FontWeight.w900,
                      )),
                ),
                SizedBox(
                    height: Responsive.height(63, context),
                    width: Responsive.width(68, context),
                    child: _totorial(context)),
                Container(
                  height: Responsive.height(13, context),
                  width: Responsive.width(68, context),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Responsive.height(10, context),
                        width: Responsive.width(12, context),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          onTap: () {
                            _lesson.game.setLevel(0);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GamePage(_lesson.game)));
                          },
                          child: Container(
                            height: Responsive.height(10, context),
                            width: Responsive.width(12, context),
                            alignment: Alignment.center,
                            child: Text('Dễ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Times New Roman",
                                  fontSize: Responsive.height(6, context),
                                  fontWeight: FontWeight.w900,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Responsive.width(5, context),
                      ),
                      Container(
                        height: Responsive.height(10, context),
                        width: Responsive.width(12, context),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                        child: InkWell(
                          onTap: () {
                            _lesson.game.setLevel(1);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GamePage(_lesson.game)));
                          },
                          child: Container(
                            height: Responsive.height(10, context),
                            width: Responsive.width(12, context),
                            alignment: Alignment.center,
                            child: Text('Khó',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Times New Roman",
                                  fontSize: Responsive.height(6, context),
                                  fontWeight: FontWeight.w900,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          );
        });
    return f;
  }

  Widget _totorial(BuildContext context) {
    String path = 'assets/images/example/';
    var img = ['', '', ''];
    var view = <Widget>[];

    for (int i = 0; i < 3; i++) {
      String s = '';
      switch (this._lesson.id) {
        case 1:
          {
            s = 'g1';
            break;
          }
        case 2:
          {
            s = 'g2';
            break;
          }
        case 3:
          {
            s = 'g3';
            break;
          }
        case 4:
          {
            s = 'g4';
            break;
          }
        case 5:
          {
            s = 'g5';
            break;
          }
        case 6:
          {
            s = 'g6';
            break;
          }
      }
      img[i] = path + s + '-$i.jpg';
      Container container = Container(
        height: Responsive.height(65, context),
        width: Responsive.width(70, context),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(img[i]), fit: BoxFit.fill)),
      );
      view.add(container);
    }
    ScrollController _scrollController = ScrollController();
    return Stack(
      children: [
        SizedBox(
            height: Responsive.height(65, context),
            width: Responsive.width(70, context),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: view,
            )),
        Container(
          height: Responsive.height(65, context),
          width: Responsive.width(70, context),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                  child: Material(
                      color: Colors.purple[900],
                      child: InkWell(
                        child: Icon(Icons.arrow_left_rounded,
                            color: Colors.yellow[200],
                            size: Responsive.height(10, context)),
                        onTap: () {
                          audioClick.click("audio/button.wav");
                          _scrollController.animateTo(
                              _scrollController.offset -
                                  Responsive.width(70, context),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                      ))),
              SizedBox(
                width: Responsive.width(58, context),
              ),
              ClipOval(
                  child: Material(
                      color: Colors.purple[900],
                      child: InkWell(
                        child: Icon(Icons.arrow_right_rounded,
                            color: Colors.yellow[200],
                            size: Responsive.height(10, context)),
                        onTap: () {
                          audioClick.click("audio/button.wav");
                          _scrollController.animateTo(
                              _scrollController.offset +
                                  Responsive.width(70, context),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                      ))),
            ],
          ),
        )
      ],
    );
  }
}
