import 'package:flutter/material.dart';

import 'dart:math';

/// Tweeny class ///

// max length of tweet
const int maxLength = 280;

// random selector for label text
final _textFieldLabelTextSelector = Random().nextInt(11);

// Char counter: number and color
List<dynamic> setCounterText(int enteredTextLength) {
  List<dynamic> counterTextAndColor = ['', Colors.black];
  int charsLeft = maxLength - enteredTextLength;

  String counterText = charsLeft.toString();

  if (enteredTextLength == 280) {
    counterTextAndColor = [counterText, Colors.redAccent];
  } else if (enteredTextLength >= 260) {
    counterTextAndColor = [counterText, Colors.amber];
  }
  return counterTextAndColor;
}

// Circular progress of counter from 20 chars left
List setCounterCircle(int enteredTextLength) {
  Color circleProgressBackgroundColor = Colors.black;
  int charsLeft =
      maxLength - enteredTextLength; // 280 - number_of_chars_entered
  double percent = (charsLeft * 1.0) /
      280; // 280 is 100%, or 1.0; then, number of chars left is 0.x: charsLeft times 1.0 by 280
  double counterCircleProgress =
      1.0 - percent; // then, progress made percentage is 1.0 minus 0.x

  List circleProgressValues = [
    Colors.black,
    circleProgressBackgroundColor,
    0.0
  ];

  // if enteredCharsNum > 0
  if (enteredTextLength > 0) {
    circleProgressBackgroundColor = Colors.grey;
  }

  if (enteredTextLength > 0 && enteredTextLength < 260) {
    circleProgressValues = [
      Colors.blue,
      circleProgressBackgroundColor,
      counterCircleProgress
    ];
  } else if (enteredTextLength == 280) {
    circleProgressValues = [
      Colors.red,
      circleProgressBackgroundColor,
      counterCircleProgress
    ];
  } else {
    circleProgressValues = [
      Colors.amber,
      circleProgressBackgroundColor,
      counterCircleProgress
    ];
  }
  return circleProgressValues;
}

// Welcoming label text
String setTextFieldLabel() {
  List<String> labels = [
    'What inspires you?',
    'Sharing your thoughts matters.',
    'Feel free to speak your mind.',
    'Share it quick and cherish time...',
    'Be present for loved ones...',
    'What does listening involve?',
    'How do you know you listen?',
    'Call that person...',
    'Sharing your thoughts matters.',
    'May virtue be your thoughts.',
    'Healthy habits are key.',
    'Take notice of what is around you.',
    'Be kind. Take care.',
    'Life is worth living.'
  ];

  String labelText = labels[_textFieldLabelTextSelector];
  return labelText;
}
