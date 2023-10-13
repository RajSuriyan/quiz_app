

import 'package:dio/dio.dart';
// int i=0;
// void main() {
//
//   getQuiz();
// }
// Future<List> getQuiz() async{
//   Dio dio = Dio();
//     var res = await dio.get(
//         "https://opentdb.com/api.php?amount=10&type=boolean");
//   print(res.data.runtimeType);
//   print(res);
//   var question=res.data["results"][0]["question"];
//   var answer=res.data["results"][0]["correct_answer"];
//
//
//
//   return [question,answer];
// }

class QuestionGenerator{
  int questionNumber=0;
  List<String> ques=["Hello, Click True to proceed the quiz!!"];
  List<String> answers=["True"];
  QuestionGenerator() {
    initialize();

  }
  void initialize() async{
    Dio dio = Dio();
    var res = await dio.get(
        "https://opentdb.com/api.php?amount=10&category=17&type=boolean");
    var data=res.data;

    for(int i=0;i<10;i++){
      String question=data["results"][i]["question"];
      String answer=data["results"][i]["correct_answer"];

      this.ques.add(question);
      this.answers.add(answer);

    }
  }

  String getQuestion(){

    return ques[questionNumber];
  }
  String getAnswer(){
    return answers[questionNumber];
  }

  void nextQuestion() {
    if (questionNumber<ques.length-1){
      questionNumber++;
    }

  }


  bool limitReached(){
    if (questionNumber>=ques.length-1){
      return true;
    }
    return false;
  }
  void resetQuestion(){
    questionNumber=0;
    this.initialize();
  }
  int getLength(){
    return ques.length;
  }

  void popOne(){
    ques.removeAt(0);
    answers.removeAt(0);
    initialize();
  }

}


