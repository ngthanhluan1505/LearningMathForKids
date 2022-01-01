import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/widgets.dart';
// ignore: unused_import
import 'package:page_transition/page_transition.dart';
import 'package:toancungbe/view_models/list_data_vm.dart';
import 'package:toancungbe/resources/my_lib.dart';
import 'view/home_page.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    audioClick.init();
    audioTotal.init();
    audioBackround.init();
    audioBackround.playAudio('audio/start.mp3', 1);
    return MaterialApp(
        home: Scaffold(
      body: _Slay(context),
      resizeToAvoidBottomInset: false,
    ));
  }

  // ignore: non_constant_identifier_names
  Widget _Slay(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage('assets/images/loading.gif'),
        fit: BoxFit.fill,
      ),
      nextScreen: _MyHome(),
      duration: 3000,
      splashIconSize: 1000,
      backgroundColor: const Color.fromARGB(0xd8, 216, 254, 255),
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(milliseconds: 500),
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}

class _MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(80, context),
      height: Responsive.height(80, context),
      decoration: const BoxDecoration(
          color: Color.fromARGB(0x82, 129, 215, 211),
          image: DecorationImage(
              image: AssetImage('assets/images/start.gif'), fit: BoxFit.fill)),
      // ignore: deprecated_member_use
      child: Row(
        children: [
          SizedBox(
            width: Responsive.width(65, context),
          ),
          Column(
            children: [
              SizedBox(
                height: Responsive.height(40, context),
              ),
              Align(
                alignment: Alignment.center,
                // ignore: avoid_unnecessary_containers
                child: Container(
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () async {
                      audioClick.click("audio/button.wav");
                      try {
                        lessons = await fetchLessons(http.Client());
                        var s = await user.loading();
                        if (s.toString() == 'FileNull') {
                          _showDL(context);
                          var lsState = '111', achie = '';
                          for (int i = 3; i < lessons.length; i++) {
                            lsState += '0';
                          }
                          user.writeLessonState(lsState);
                          user.writeStar('40');
                          user.writeCandy('20');
                          for (int i = 0; i < 10; i++) {
                            achie += '0';
                          }
                          user.writeAchievement(achie);
                          loadLessons(await user.loadLessonState());
                          user.setName(await user.loading());
                          user.achievements = await user.loadAchievement();
                          user.star = await user.loadStar();
                          user.candy = await user.loadCandy();
                        } else {
                          user.star = await user.loadStar();
                          user.candy = await user.loadCandy();
                          user.setName(await user.loading());
                          loadLessons(await user.loadLessonState());
                          user.achievements = await user.loadAchievement();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }
                      } catch (ex) {
                        _notConnect(context);
                      }
                    },
                    child: SizedBox(
                      width: Responsive.width(12, context),
                      height: Responsive.height(30, context),
                      child: const Text(' '),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showDL(BuildContext context) {
    String data = '';
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                height: Responsive.height(40, context),
                width: Responsive.width(50, context),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Responsive.height(10, context),
                      width: Responsive.width(40, context),
                      child: Text('Tên bé là:',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontSize: Responsive.height(5, context),
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                    SizedBox(
                        height: Responsive.height(10, context),
                        width: Responsive.width(40, context),
                        child: TextField(
                          onChanged: (text) {
                            data = text;
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '...',
                              hintStyle: TextStyle(color: Colors.white)),
                        )),
                    SizedBox(
                      height: Responsive.height(2, context),
                    ),
                    Container(
                      height: Responsive.height(10, context),
                      width: Responsive.width(15, context),
                      color: Colors.red,
                      child: InkWell(
                        onTap: () async {
                          data = data.trim();
                          if (data == "") return;
                          if (data.length > 10) {
                            _nameLong(context);
                            return;
                          }
                          SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.manual,
                              overlays: [SystemUiOverlay.bottom]);
                          user.setName(data);
                          user.writing(data);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                        child: Container(
                          height: Responsive.height(10, context),
                          width: Responsive.width(15, context),
                          alignment: Alignment.center,
                          child: Text('Vào',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontSize: Responsive.height(5, context),
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  void _nameLong(BuildContext context) {
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
                  'Tên bé dài thế?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Responsive.height(8, context)),
                ),
              ));
        });
  }

  void _notConnect(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: Responsive.height(40, context),
              width: Responsive.width(60, context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Responsive.height(15, context),
                    width: Responsive.width(55, context),
                    child: Row(
                      children: [
                        Container(
                          height: Responsive.height(15, context),
                          width: Responsive.width(50, context),
                          alignment: Alignment.centerLeft,
                          child: Text('  Thông báo',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontSize: Responsive.height(6, context),
                                fontWeight: FontWeight.bold,
                              )),
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
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: Responsive.height(15, context),
                      width: Responsive.width(55, context),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Bé hãy mở Wifi hoặc Mạng điện thoại để bắt đầu học nhé!',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontSize: Responsive.height(4, context),
                                fontWeight: FontWeight.normal,
                              )),
                          SizedBox(
                            height: Responsive.height(3, context),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: Responsive.height(2, context),
                  )
                ],
              ),
            ),
          );
        });
  }
}
