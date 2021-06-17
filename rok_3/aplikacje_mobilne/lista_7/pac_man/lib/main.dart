import 'package:flutter/material.dart';

import 'homepage.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
void main() {
  runApp(Phoenix(child: MyApp()));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
