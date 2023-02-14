import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:tweeny/services/tweet.dart';
import 'package:tweeny/widgets/home_floating_button.dart';
import 'package:tweeny/widgets/home_text_field.dart';

class Tweeny extends StatefulWidget {
  Tweeny({Key? key}) : super(key: key);

  @override
  State<Tweeny> createState() => _TweenyState();
}

class _TweenyState extends State<Tweeny> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
              tooltip: 'Menu',
            );
          }),
        ),
        body: HomeTextField(),
        floatingActionButton: HomeFloatingButton());
  }
}
