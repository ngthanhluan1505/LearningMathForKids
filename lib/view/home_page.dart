import 'package:flutter/material.dart';
import 'package:toancungbe/view_models/list_data_vm.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'package:toancungbe/view/achievement_page.dart';
import 'lesson_page.dart';
// ignore: unused_import
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage('assets/images/loadpage.gif'),
        fit: BoxFit.cover,
      ),
      nextScreen: _bodyHome(),
      duration: 3000,
      splashIconSize: 2000,
      backgroundColor: HexColor("#db8272"),
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class _bodyHome extends StatelessWidget {
  String _star = '';
  String _candy = '';
  final ScrollController _scrollController = ScrollController();
  _bodyHome({Key? key}) : super(key: key) {
    _star = user.star.toString();
    _candy = user.candy.toString();
  }

  Widget _listLesson(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Responsive.height(18, context),
        ),
        SizedBox(
          height: Responsive.height(60, context),
          width: Responsive.width(100, context),
          // color: Colors.black,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: lessons.map((lesson) {
              return Stack(
                children: [
                  Container(
                    height: Responsive.height(60, context),
                    width: Responsive.width(32, context),
                    padding:
                        EdgeInsets.only(top: Responsive.height(4, context)),
                    child: GestureDetector(
                      onTap: () {
                        if (lesson.state == 0) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    height: Responsive.height(65, context),
                                    width: Responsive.width(60, context),
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height:
                                                Responsive.height(15, context),
                                            width:
                                                Responsive.width(60, context),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20)),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: Responsive.height(
                                                      15, context),
                                                  width: Responsive.width(
                                                      50, context),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      '  Mở khóa bài học',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontSize:
                                                            Responsive.height(
                                                                5, context),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    audioClick.click(
                                                        "audio/button.wav");
                                                    Navigator.pop(context);
                                                  },
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: Responsive.height(
                                                          10, context),
                                                      width: Responsive.height(
                                                          10, context),
                                                      color: Colors.green,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.red[700],
                                                        size: Responsive.height(
                                                            8, context),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: Responsive.height(
                                                  50, context),
                                              width:
                                                  Responsive.width(60, context),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.amber[200],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1)),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: Responsive.height(
                                                        40, context),
                                                    width: Responsive.width(
                                                        20, context),
                                                    decoration:
                                                        const BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/hi.gif'),
                                                      fit: BoxFit.fill,
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: Responsive.width(
                                                        2, context),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height:
                                                            Responsive.height(
                                                                30, context),
                                                        width: Responsive.width(
                                                            35, context),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .blue[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1)),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: Responsive
                                                                  .height(10,
                                                                      context),
                                                              width: Responsive
                                                                  .width(20,
                                                                      context),
                                                              child: Text('-10',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "Times New Roman",
                                                                    fontSize: Responsive
                                                                        .height(
                                                                            8,
                                                                            context),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .star_rounded,
                                                              color: Colors
                                                                  .yellow[900],
                                                              size: Responsive
                                                                  .height(10,
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Responsive.height(
                                                                2, context),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (user.star >= 10) {
                                                            user.star -= 10;
                                                            user.writeStar(user
                                                                .star
                                                                .toString());
                                                            lesson.setState(1);
                                                            user.writeLessonState(
                                                                dataLessonsState());
                                                            audioBackround
                                                                .pauseAudio();
                                                            audioBackround
                                                                .dispose();
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      LessonPage(
                                                                          lesson)),
                                                            );
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    true,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Dialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20)),
                                                                      child:
                                                                          Container(
                                                                        height: Responsive.height(
                                                                            20,
                                                                            context),
                                                                        width: Responsive.width(
                                                                            40,
                                                                            context),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            border: Border.all(width: 1, color: Colors.black),
                                                                            color: Colors.amber[200]),
                                                                        child:
                                                                            Text(
                                                                          'Bé không đủ sao rồi!',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(fontSize: Responsive.height(8, context)),
                                                                        ),
                                                                      ));
                                                                });
                                                          }
                                                        },
                                                        child: Container(
                                                          height:
                                                              Responsive.height(
                                                                  10, context),
                                                          width:
                                                              Responsive.width(
                                                                  10, context),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: Colors
                                                                  .pink[200]),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text('OK',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "Times New Roman",
                                                                fontSize: Responsive
                                                                    .height(5,
                                                                        context),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ))
                                        ]),
                                  ),
                                );
                              });
                        } else {
                          audioBackround.pauseAudio();
                          audioBackround.dispose();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LessonPage(lesson)),
                          );
                        }
                      },
                      child: Container(
                        height: Responsive.height(20, context),
                        width: Responsive.width(32, context),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/homepage/moctreo.png'),
                              fit: BoxFit.fill),
                        ),
                        child: Container(
                            height: Responsive.height(35, context),
                            width: Responsive.width(25, context),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.brown,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: lesson.state != 0
                                      ? AssetImage(lesson.image)
                                      : const AssetImage(
                                          'assets/images/lock.jpg'),
                                  fit: BoxFit.fill),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    height: Responsive.height(10, context),
                    width: Responsive.width(32, context),
                    alignment: Alignment.center,
                    //    color: Colors.amber,
                    child: Container(
                      height: Responsive.height(7, context),
                      width: Responsive.width(10, context),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Text(
                          lesson.name.substring(0, lesson.name.indexOf(","))),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/homepage/homebr.gif'),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Container(
                height: Responsive.height(20, context),
                width: Responsive.height(20, context),
                padding: const EdgeInsets.all(10),
                child: SizedBox.fromSize(
                    size: const Size(55, 55),
                    child: ClipOval(
                      child: Material(
                        color: Colors.greenAccent[700],
                        child: InkWell(
                          splashColor: Colors.orange[300],
                          onTap: () {
                            audioClick.click("audio/button.wav");
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.house_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: Responsive.height(60, context),
              ),
              Container(
                height: Responsive.height(18, context),
                width: Responsive.width(100, context),
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: Row(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.black,
                        child: InkWell(
                          onTap: () {
                            audioClick.click("audio/button.wav");
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      height: Responsive.height(60, context),
                                      width: Responsive.width(60, context),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height:
                                                Responsive.height(15, context),
                                            width:
                                                Responsive.width(55, context),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Responsive.height(
                                                      15, context),
                                                  width: Responsive.width(
                                                      50, context),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text('  Thông tin',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontSize:
                                                            Responsive.height(
                                                                6, context),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    audioClick.click(
                                                        "audio/button.wav");
                                                    Navigator.pop(context);
                                                  },
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: Responsive.height(
                                                          10, context),
                                                      width: Responsive.height(
                                                          10, context),
                                                      color: Colors.green,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.red[700],
                                                        size: Responsive.height(
                                                            8, context),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: Responsive.height(
                                                  40, context),
                                              width:
                                                  Responsive.width(55, context),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'Đây là ứng dụng demo sử dụng với mục đích học tập và nghiên cứu. Sản phẩm có sử dụng'
                                                      ' video trên một số kênh Youtube dành cho trẻ em và có trích dẫn nguồn đầy đủ.',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontSize:
                                                            Responsive.height(
                                                                4, context),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                  SizedBox(
                                                    height: Responsive.height(
                                                        1, context),
                                                  ),
                                                  Text(
                                                      'Sinh viên thực hiện: B1805785 - Nguyễn Thanh Luân',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontSize:
                                                            Responsive.height(
                                                                4, context),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                  SizedBox(
                                                    height: Responsive.height(
                                                        1, context),
                                                  ),
                                                  Text(
                                                      'Khoa CNTT-TT, Đại học Cần Thơ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontSize:
                                                            Responsive.height(
                                                                4, context),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.pending_rounded,
                            color: Colors.amber[700],
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                      child: InkWell(
                        onTap: () async {
                          audioClick.click("audio/button.wav");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Achievement()),
                          );
                        },
                        child: Icon(
                          Icons.book_rounded,
                          color: Colors.amber[700],
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    Container(
                      width: Responsive.width(10, context),
                      padding: const EdgeInsets.only(top: 2, left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 30,
                          ),
                          Material(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            child: Text(
                              _star,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(1, context),
                    ),
                    Container(
                      width: Responsive.width(10, context),
                      padding: const EdgeInsets.only(top: 2, left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/candy.jpg',
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                          Material(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            child: Text(
                              _candy,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(10, context),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.pink,
                        child: InkWell(
                          onTap: () {
                            audioClick.click("audio/button.wav");
                            _scrollController.animateTo(
                                _scrollController.offset -
                                    Responsive.width(32, context) * 3,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear);
                          },
                          child: Icon(
                            Icons.arrow_left_rounded,
                            color: Colors.amber[200],
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(10, context),
                    ),
                    ClipOval(
                      child: Material(
                        color: Colors.pink,
                        child: InkWell(
                          onTap: () {
                            audioClick.click("audio/button.wav");
                            _scrollController.animateTo(
                                _scrollController.offset +
                                    Responsive.width(32, context) * 3,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.linear);
                          },
                          child: Icon(
                            Icons.arrow_right_rounded,
                            color: Colors.amber[200],
                            size: 40,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
            _listLesson(context)
          ],
        ),
      ),
    );
  }
}
