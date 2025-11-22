import 'package:flutter/material.dart';

import '../Model/Question.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final tickIcon = const Icon(Icons.check, color: Colors.green);
  final crossIcon = const Icon(Icons.clear, color: Colors.red);
  int count = 0;
  //List of Icons which is added to the bottom of the screen
  List<Icon> iconsList = [];

  final List<Question> questionsList = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _body(),
      ),
    );
  }

  _body() {
    ///
    /// Column1
    ///
    return Column(
      // Divide the the vertical space between the children
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      // Stretch the children horizontally to the screen size
      // as we need to stretch the buttons
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[
        Center(

          ///
          /// Text Widget with some padding
          ///
            child: Padding(
              padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
              child: Text(
                questionsList[count].question,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.black, // Shadow color
                elevation: 5, // Elevation of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding
                backgroundColor: Colors.green
              ),
              onPressed: () {
                _checkAnswer(true);
              },
            ),
            SizedBox(height: 8),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'False',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.black, // Shadow color
                elevation: 5, // Elevation of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding
                  backgroundColor: Colors.red
              ),
              onPressed: () {
                _checkAnswer(false);
              },
            ),
            Row(children: iconsList)
          ],
        ),
        SizedBox(height: 1)
      ],
    );
  }

  _checkAnswer(selectedAnswer) {
    if (selectedAnswer == questionsList[count].correctAnswer) {
      //Correct answer

      setState(() {
        iconsList.add(tickIcon);

        // Check if don't cross list size limit which will result in error
        if (count < questionsList.length - 1) count++;
      });
    } else {
      //Incorrect answer
      setState(() {
        iconsList.add(crossIcon);

        // Check if don't cross list size limit which will result in error
        if (count < questionsList.length - 1) count++;
      });
    }
  }
}