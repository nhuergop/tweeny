import 'package:flutter/material.dart';

import 'package:tweeny/utils/elem_values.dart';

import 'package:tweeny/widgets/home_text_counter.dart';

class HomeTextField extends StatefulWidget {
  const HomeTextField({Key? key}) : super(key: key);

  @override
  State<HomeTextField> createState() => _HomeTextFieldState();
}

class _HomeTextFieldState extends State<HomeTextField> {
  final TextEditingController _textFieldController = TextEditingController();
  String _enteredText = '';

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    double _textFieldFontSize = (10 * _screen.width) / 100;
    int _textFieldMaxLines = 5;
    List _textFieldFontProperties = [_textFieldFontSize, _textFieldMaxLines];

    List _changeTextFieldFontProperties() {
      // not possible range option choosing with switch()
      if (_enteredText.length >= 100) {
        _textFieldFontSize = (6 * _screen.width) / 100;
        _textFieldMaxLines = 8;
        return _textFieldFontProperties = [
          _textFieldFontSize,
          _textFieldMaxLines
        ];
      } else if (_enteredText.length >= 50) {
        _textFieldFontSize = (8 * _screen.width) / 100;
        _textFieldMaxLines = 6;
        return _textFieldFontProperties = [
          _textFieldFontSize,
          _textFieldMaxLines
        ];
      } else {
        return _textFieldFontProperties;
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        TextField(
          minLines: 1,
          maxLines: _changeTextFieldFontProperties()[1],
          maxLength: 280,
          controller: _textFieldController,
          cursorColor: Colors.white,
          style: TextStyle(
              fontSize: _changeTextFieldFontProperties()[0],
              color: Colors.white),
          decoration: InputDecoration(
            // constraints: BoxConstraints(),
            labelText: setTextFieldLabel(),
            labelStyle: TextStyle(
                color: Colors.white, fontSize: (5 * _screen.width) / 100),
            alignLabelWithHint: false,
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            counterText: '',
          ),
          onChanged: (value) {
            setState(() {
              _enteredText = value;
            });
          },
        ),
        HomeTextCounter(enteredText: _enteredText, screen: _screen),
      ]),
    );
  }
}
