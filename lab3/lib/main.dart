import 'package:flutter/material.dart';
import 'dart:math';

// Creates a Material App
void main() => runApp(
  MaterialApp(
    home: MyApp(),
  ),
);

// Creates a Scaffold with
// appbar using Stateless widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Roll Dice App'),
      ),
      body: Dice(),
    );
  }
}

// Creates a Stateful widget
class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Dice> {
  int indexDiceOne = 1;
  int indexDiceTwo = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {

            indexDiceOne = Random().nextInt(5) + 1;
            indexDiceTwo = Random().nextInt(5) + 1;
          });
        },
        // Adding images
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/dice-$indexDiceOne.png',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/dice-$indexDiceTwo.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}