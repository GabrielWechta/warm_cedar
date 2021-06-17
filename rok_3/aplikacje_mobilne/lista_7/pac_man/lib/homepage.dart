import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pac_man/path.dart';
import 'package:pac_man/pixel.dart';
import 'package:pac_man/player.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  int playerPosition = numberInRow * 14 + 1;

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    98,
    87,
    76,
    65,
    54,
    43,
    32,
    21
  ];

  List<int> food = [];
  String direction = "right";
  double timeLeft = 60000.0;

  void moveRight() {
    if (!barriers.contains(playerPosition + 1)) {
      setState(() {
        playerPosition++;
      });
    }
  }

  void moveLeft() {
    if (!barriers.contains(playerPosition - 1)) {
      setState(() {
        playerPosition--;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(playerPosition - numberInRow)) {
      setState(() {
        playerPosition -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(playerPosition + numberInRow)) {
      setState(() {
        playerPosition += numberInRow;
      });
    }
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  void addRandomWalls(int howMany) {
    int added = 0, guess = 0;
    var rng = new Random();
    while (added < howMany) {
      guess = rng.nextInt(numberOfSquares);
      if (!barriers.contains(guess)) {
        barriers.add(guess);
        added++;
      }
    }
  }

  void endGame(bool isWin) {
    AlertDialog alert;

    if (isWin) {
      alert = AlertDialog(
        title: Text("You won!"),
        content: Text("Wow, well done, sir!"),
      );
    } else {
      alert = AlertDialog(
        title: Text("You died."),
        content: Text("Not quick enough."),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void startGame() {

    getFood();
    addRandomWalls(numberOfSquares ~/ 4);
    var duration = Duration(milliseconds: 150);
    Timer.periodic(duration, (timer) {
      setState(() {
        timeLeft -= duration.inMilliseconds;
      });

      if (timeLeft <= 0 || food.length == 0) {
        endGame(food.length == 0);
        timer.cancel();
      }

      if (food.contains(playerPosition)) {
        food.remove(playerPosition);
      }

      switch (direction) {
        case "right":
          moveRight();
          break;
        case "left":
          moveLeft();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    direction = "down";
                  } else if (details.delta.dy < 0) {
                    direction = "up";
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    direction = "right";
                  } else if (details.delta.dx < 0) {
                    direction = "left";
                  }
                },
                child: Container(
                  color: Colors.black87,
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: numberOfSquares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numberInRow),
                      itemBuilder: (BuildContext context, int index) {
                        if (playerPosition == index) {
                          switch (direction) {
                            case "right":
                              return MyPlayer();
                            case "left":
                              return Transform.rotate(
                                angle: pi,
                                child: MyPlayer(),
                              );
                            case "up":
                              return Transform.rotate(
                                angle: 3 * pi / 2,
                                child: MyPlayer(),
                              );
                            case "down":
                              return Transform.rotate(
                                angle: pi / 2,
                                child: MyPlayer(),
                              );
                            default:
                              return MyPlayer();
                          }
                        } else if (barriers.contains(index)) {
                          return MyPixel(
                              Colors.lightBlueAccent, Colors.blueAccent);
                        } else if (food.contains(index)) {
                          return MyPath(
                            Colors.lime,
                            Colors.black87,
                          );
                        } else {
                          return MyPath(
                            Colors.black87,
                            Colors.black87,
                          );
                        }
                      }),
                ),
              )),
          Expanded(
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Score: ${timeLeft ~/ 1000}",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      GestureDetector(
                        onTap: startGame,
                        child: Text(
                          "Play",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  color: Colors.black87)),
        ],
      ),
    );
  }
}
