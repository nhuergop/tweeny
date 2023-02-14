import 'package:flutter/material.dart';

import 'package:tweeny/utils/elem_values.dart';

import 'package:percent_indicator/percent_indicator.dart';

class HomeTextCounter extends StatefulWidget {
  final String enteredText;
  final Size screen;

  HomeTextCounter({Key? key, required this.enteredText, required this.screen})
      : super(key: key);

  @override
  State<HomeTextCounter> createState() => _HomeTextCounterState();
}

class _HomeTextCounterState extends State<HomeTextCounter> {
  @override
  Widget build(BuildContext context) {
    List counterCircleProgress = setCounterCircle(widget.enteredText.length);
    List counterText = setCounterText(widget.enteredText.length);

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.all(5.0),
          child: CircularPercentIndicator(
            animation: false,
            animationDuration: 0,
            radius: (5 * widget.screen.width) / 100,
            lineWidth: 3.0,
            percent: counterCircleProgress[2],
            progressColor: counterCircleProgress[0],
            backgroundColor: counterCircleProgress[1],
            center: Text(counterText[0],
                style: TextStyle(
                    color: counterText[1],
                    fontSize: (5 * widget.screen.width) / 100)),
          )),
      GestureDetector(
        // add tweet to bulk tweet here
        child: Center(),
        onTap: () {},
      )
    ]);
  }
}
