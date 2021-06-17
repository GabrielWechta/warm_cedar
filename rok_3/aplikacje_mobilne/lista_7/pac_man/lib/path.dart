import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innerColor;
  final outerColor;

  const MyPath(this.innerColor, this.outerColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            padding: EdgeInsets.all(10),
            color: outerColor,
            child: Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                color: innerColor,
              ),
            )),
          ),
        ));
  }
}
