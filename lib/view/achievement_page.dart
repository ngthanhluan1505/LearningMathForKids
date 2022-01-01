import 'package:flutter/material.dart';
import 'package:toancungbe/view_models/list_data_vm.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/home_page.dart';

class Achievement extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Achievement();

  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/brachi.gif'),
                fit: BoxFit.fill)),
        child: Column(
          children: [_header(context), _body(context)],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    String name = user.nameUser;
    if (name.length > 5) {
      name = name.substring(0, 5) + "...";
    }
    return SizedBox(
      height: Responsive.height(20, context),
      width: Responsive.width(100, context),
      child: Row(
        children: [
          SizedBox(
            width: Responsive.width(2, context),
          ),
          ClipOval(
              child: Material(
                  color: Colors.green,
                  child: InkWell(
                    child: Icon(Icons.arrow_left_rounded,
                        color: Colors.black,
                        size: Responsive.height(15, context)),
                    onTap: () {
                      audioClick.click("audio/button.wav");
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                  ))),
          SizedBox(
            width: Responsive.width(2, context),
          ),
          Container(
            height: Responsive.height(10, context),
            width: Responsive.width(15, context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.yellow[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.black)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bé:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.height(4.5, context),
                      decoration: TextDecoration.none,
                    )),
                SizedBox(
                  width: Responsive.width(1, context),
                ),
                Text(name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.height(4.5, context),
                      decoration: TextDecoration.none,
                    )),
              ],
            ),
          ),
          SizedBox(
            width: Responsive.width(59, context),
          ),
          Container(
            height: Responsive.height(10, context),
            width: Responsive.width(12, context),
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
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: Responsive.height(8, context),
                ),
                Text(
                  '${user.star}',
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontSize: Responsive.height(5, context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      height: Responsive.height(80, context),
      width: Responsive.width(100, context),
      child:
          CustomScrollView(scrollDirection: Axis.horizontal, slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                //color: Colors.blue[100],
                height: Responsive.height(80, context),
                width: Responsive.width(330, context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _bodyNode(context),
                    _bodyAvatar(context),
                    _bodyTopic(context)
                  ],
                ),
              );
            },
            childCount: 1,
          ),
        )
      ]),
    );
  }

  Widget _bodyTopic(BuildContext context) {
    Widget _spaceW = SizedBox(
      width: Responsive.width(10, context),
    );
    var _listTopic = <Widget>[];
    for (int i = 0; i < 10; i++) {
      var _topic = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: Responsive.height(20, context),
                width: Responsive.width(17 + 5, context),
                alignment: Alignment.center,
                child: user.achievements[i] == 1
                    ? Container(
                        height: Responsive.height(10, context),
                        width: Responsive.width(17 + 5, context),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.black)),
                        child: Text(_nameAchi(i + 1),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Responsive.height(5, context))),
                      )
                    : Container()),
            SizedBox(
              height: Responsive.height(60, context),
            )
          ]);
      _listTopic.add(_topic);
      if (i < 9) {
        _listTopic.add(_spaceW);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _listTopic,
    );
  }

  Widget _bodyAvatar(BuildContext context) {
    Widget _spaceW = SizedBox(
      width: Responsive.width(20, context),
    );
    var _listAvatar = <Widget>[];
    for (int i = 0; i < 10; i++) {
      var _ava = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Responsive.height(22, context),
            width: Responsive.width(12, context),
            decoration: BoxDecoration(
                // color: Colors.amber,
                image: DecorationImage(
                    image: user.achievements[i] == 1
                        ? const AssetImage('assets/images/open.gif')
                        : const AssetImage('assets/images/asw.png'),
                    fit: BoxFit.fill)),
          ),
          user.achievements[i] == 1
              ? SizedBox(
                  height: Responsive.height(20, context),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      _open(context, i);
                    });
                  },
                  child: Container(
                    height: Responsive.height(20, context),
                    width: Responsive.width(12, context),
                    alignment: Alignment.center,
                    child: Container(
                      height: Responsive.height(10, context),
                      width: Responsive.width(10, context),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.black)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber[800],
                            size: Responsive.height(8, context),
                          ),
                          SizedBox(
                            width: Responsive.width(1, context),
                          ),
                          Text('${(i + 1) * 10}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Responsive.height(5, context)))
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      );
      _listAvatar.add(_ava);
      if (i < 9) {
        _listAvatar.add(_spaceW);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _listAvatar,
    );
  }

  Widget _bodyNode(BuildContext context) {
    var _listNode = <Widget>[];
    for (int i = 0; i < 10; i++) {
      Widget _node = Container(
          height: Responsive.height(5, context),
          width: Responsive.width(12, context),
          //  color: Colors.red,
          alignment: Alignment.center,
          child: ClipOval(
              child: Container(
            height: Responsive.height(5, context),
            width: Responsive.width(5, context),
            color: user.achievements[i] == 1 ? Colors.orange : Colors.white,
          )));
      _listNode.add(_node);

      if (i < 9) {
        Widget _land = Container(
            height: Responsive.height(5, context),
            width: Responsive.width(20, context),
            alignment: Alignment.center,
            //color: Colors.white,
            child: const Text(
              "------------------",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ));
        _listNode.add(_land);
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _listNode,
    );
  }

  void _open(BuildContext context, int i) async {
    audioClick.click("audio/button.wav");
    if (user.star >= 10 * (i + 1)) {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            audioTotal.click("audio/win.mp3");
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: Responsive.height(100, context),
                width: Responsive.width(100, context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/sc.gif'),
                        fit: BoxFit.fill)),
              ),
            );
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.pop(context);
      });
      setState(() {
        user.achievements[i] = 1;
        user.star -= 10 * (i + 1);
        user.writeStar(user.star.toString());
        user.writeAchievement(dataAchievement());
      });
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: Responsive.height(20, context),
                  width: Responsive.width(40, context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black),
                      color: Colors.amber[200]),
                  child: Text(
                    'Bé không đủ sao rồi!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: Responsive.height(8, context)),
                  ),
                ));
          });
    }
  }

  String _nameAchi(int i) {
    String rs = '';
    switch (i) {
      case 1:
        {
          rs = 'Khởi đầu thuận lợi';
          break;
        }
      case 2:
        {
          rs = 'Toán học là bạn';
          break;
        }
      case 3:
        {
          rs = 'Cùng nhau cố gắng';
          break;
        }
      case 4:
        {
          rs = 'Bé ngoan học tốt';
          break;
        }
      case 5:
        {
          rs = 'Học sinh khá';
          break;
        }
      case 6:
        {
          rs = 'Học sinh giỏi';
          break;
        }
      case 7:
        {
          rs = 'Học sinh xuất sắc ';
          break;
        }
      case 8:
        {
          rs = 'Học sinh ưu tú';
          break;
        }
      case 9:
        {
          rs = 'Thiên tài toán học';
          break;
        }
      case 10:
        {
          rs = 'IQ vô cực';
          break;
        }
    }
    return rs;
  }
}
