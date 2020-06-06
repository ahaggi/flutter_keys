import 'package:flutter/material.dart';
import 'package:keys_flutter/theStateful1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TheStateful1(title: 'Flutter Demo statefulWidget/keys'),/// https://medium.com/flutter/keys-what-are-they-good-for-13cb51742e7d
    );
  }
}

