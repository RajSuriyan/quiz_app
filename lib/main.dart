

import 'dart:io';

import 'getApi.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

// QuizzBrain quizzBrain=QuizzBrain();
// int length=quizzBrain.getLength();

QuestionGenerator quizzBrain=QuestionGenerator();


void main() {
  quizzBrain.initialize();


  quizzBrain.initialize();



  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}



class _QuizPageState extends State<QuizPage> {




  List<Widget> score_keeper=[];
  // List<String> questions=['You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  // 'A slug\'s blood is green'];
  // List<bool> answers=[false,true,true];
   void checkAnswer(String userInputAnswer){
     setState(() {

       if (quizzBrain.limitReached() || score_keeper.length==10){
         onBasicWaitingAlertPressed(context) async {
           Alert(
             context: context,
             title: "End Of The Quiz",
             desc: "You have completed the entire Quizz.New set of questions will be comming now.",
           ).show();
           quizzBrain.initialize();
           score_keeper = [];
         }
         onBasicWaitingAlertPressed(context);


       }else {
         if (quizzBrain.getAnswer() == userInputAnswer) {
           score_keeper.add(
               Icon(
                 Icons.check,
                 color: Colors.green,
               )
           );
         }
         else {
           score_keeper.add(
               Icon(
                 Icons.close,
                 color: Colors.red,
               )
           );
         }
         if(quizzBrain.getLength()>=10) {
           quizzBrain.nextQuestion();
         }
       }

     });


   }


  @override
  Widget build(BuildContext context) {




    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
         Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                  color: Colors.white,
                )

              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer("True");
                //The user picked true.
                // setState(() {
                //
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: TextStyle(
                  color: Colors.white,
                )
              ),
              child:  Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer("False");

                //The user picked false.
                // setState(() {
                //   score_keeper.add(
                //     Icon(
                //       Icons.close,
                //       color: Colors.red,
                //     )
                //   );
                // });
              },
            ),
          ),
        ),
        Row(
          children:score_keeper,
        ),

      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/