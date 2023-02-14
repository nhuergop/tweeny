import 'package:flutter/material.dart';
import 'package:tweeny/pages/tweeny.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweeny',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
        primaryColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      // darkTheme: ThemeData(brightness: Brightness.dark),
      home: Tweeny(),
    );
  }
}
