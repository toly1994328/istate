import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:istate/10/data/data.dart';


void main() {
  List<String> nums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> small_letters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  List<String> bigLetters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  Set<String> titles = {};

  while (titles.length < 100) {
    titles.add(randomFromList(bigLetters, 3));
  }

  List<Secret> secrets = [];
  int i = 0;
  DateTime now = DateTime.now();
  for (String title in titles) {
    secrets.add(Secret(
        title: "领域 "+title,
        secret: randomFromList(nums, 6),
        createAt: now.add(Duration(hours: -i)).millisecondsSinceEpoch,
        updateAt: now.add(Duration(hours: -i)).millisecondsSinceEpoch,
    ));
    i++;
  }
  String result = json.encode(secrets);
  File file = File(r'D:\Projects\Flutter\istate\assets\data\secret.json');
  file.writeAsString(result);
  // print(result);
}

Random random = Random();

String randomFromList(List<String> src, int length) {
  String result = '';
  for (int i = 0; i < length; i++) {
    result += src[random.nextInt(src.length)];
  }
  return result;
}
