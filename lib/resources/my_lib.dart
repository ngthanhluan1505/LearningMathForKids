import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class Responsive {
  /* Chia màn hình theo tỷ lệ phần trăm
    height: Responsive.height(50, context) => 50% chiều dọc
    width: Responsive.width(100, context) => 100% chiều ngang
  */
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

int random(int k) {
  // Tạo ngẫu nhiên 1 số từ 1->k
  Random rd = Random();
  int result = rd.nextInt(k);
  return result;
}

void blend(List<int> arr) {
  for (int i = arr.length - 1; i > 0; i--) {
    int index = random(i + 1);
    // Simple swap
    int a = arr[index];
    arr[index] = arr[i];
    arr[i] = a;
  }
}

bool inMart(List<int> mart, int n) {
  for (int i = 0; i < mart.length; i++) {
    if (mart[i] == n) return true;
  }
  return false;
}

List<int> copy(List<int> arr) {
  var e = <int>[];
  for (int i = 0; i < arr.length; i++) {
    e.add(arr[i]);
  }
  return e;
}

String tesss(List<int> arr) {
  String s = '';
  for (int i = 0; i < arr.length; i++) {
    s += '${arr[i]} ';
  }
  return s;
}

void sort(List<int> exam, int flag) {
  int i, j, n = exam.length;
  if (flag == 0) {
    for (i = 0; i <= n - 2; i++)
      // ignore: curly_braces_in_flow_control_structures
      for (j = n - 1; j >= i + 1; j--) {
        if (exam[j] < exam[j - 1]) {
          int temp = exam[j];
          exam[j] = exam[j - 1];
          exam[j - 1] = temp;
        }
      }
  } else
    // ignore: curly_braces_in_flow_control_structures
    for (i = 0; i <= n - 2; i++) {
      for (j = n - 1; j >= i + 1; j--) {
        if (exam[j] > exam[j - 1]) {
          int temp = exam[j];
          exam[j] = exam[j - 1];
          exam[j - 1] = temp;
        }
      }
    }
}

class AudioBackroundManager {
  late AudioPlayer audioPlayer;
  late AudioCache audioCache;

  AudioBackroundManager();

  void init() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(
      fixedPlayer: audioPlayer..setReleaseMode(ReleaseMode.STOP),
    );
  }

  void dispose() {
    audioPlayer.stop();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
  }

  Future<void> playAudio(String link, int flag) async {
    await audioCache.load(link);
    if (flag == 0) {
      await audioCache.play(link);
    } else {
      await audioCache.loop(link);
      audioPlayer.setVolume(0.4);
    }
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> click(String path) async {
    audioCache.load(path);
    audioCache.play(path);
  }
}

AudioBackroundManager audioBackround = AudioBackroundManager();
AudioBackroundManager audioClick = AudioBackroundManager();
AudioBackroundManager audioTotal = AudioBackroundManager();

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> localFile(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  Future<String> readData(String fileName) async {
    try {
      final file = await localFile(fileName);
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return 'FileNull';
    }
  }

  Future<File> writeData(String data, String fileName) async {
    final file = await localFile(fileName);
    return file.writeAsString(data);
  }

  Future delete(String fileName) async {
    final file = await localFile(fileName);
    file.delete();
  }
}

late Timer time;
