import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_game/data/provider/Category.dart';
import 'package:question_game/model/question.dart';
import 'package:question_game/screen/ending/ending.dart';
import 'package:question_game/service/api_service.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:auto_size_text/auto_size_text.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Future<List<Question>> question;

  int question_count = 0;
  String question_content = "";
  List<String> nowQuestion = [];
  List<bool> gameStatus = [];
  List<Question> qustion_data = [];
  bool isPlaying = true;
  bool isCorrect = false;
  bool select = false;
  int yourSelect = 1;
  bool gameEnd = false;

  var unescape = HtmlUnescape();

  final CountDownController _controller = CountDownController();
  @override
  void initState() {
    super.initState();
    question = ApiServcie().getQuestion(context.read<Category>().path);
  }

  List<String> shuffle(List<String> items) {
    var random = Random();
    for (int i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var tmp = items[i];
      items[i] = items[n];
      items[n] = tmp;
    }
    return items;
  }

  void nextQuestion() {
    if (question_count < qustion_data.length) {
      setState(() {
        isCorrect = false;
        isPlaying = true;
        yourSelect = 1;
        select = false;

        _controller.restart(duration: 30);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: isPlaying
          ? const Color.fromARGB(255, 227, 227, 238)
          : isCorrect
              ? Colors.blue.shade100
              : Colors.red.shade100,
      appBar: AppBar(
        title: Text(
          "${question_count + 1} Question",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 252, 142, 25),
              Color.fromARGB(255, 254, 97, 13)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
      ),
      body: FutureBuilder(
        future: question,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!select) {
              qustion_data = snapshot.data!;
              question_content = qustion_data[question_count].question;
              gameStatus = List.filled(
                  qustion_data[question_count].type == "multiple" ? 4 : 2,
                  false);
              nowQuestion = [qustion_data[question_count].correct_answer];
              nowQuestion.addAll(qustion_data[question_count]
                  .incorrect_answers
                  .map((e) => e.toString()));
              nowQuestion = shuffle(nowQuestion);
              gameStatus[nowQuestion
                  .indexOf(qustion_data[question_count].correct_answer)] = true;
            }

            return Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width *
                        ((question_count + 1) / qustion_data.length),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blue.withOpacity(0.4),
                        Colors.blue.withOpacity(0.7),
                        Colors.blue
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                  ),
                ),
                Text(
                  "${question_count + 1} / ${qustion_data.length}",
                  textAlign: TextAlign.end,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    unescape.convert(question_content),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CircularCountDownTimer(
                  duration: 30,
                  initialDuration: 0,
                  controller: _controller,
                  ringColor: Colors.white,
                  fillColor: Colors.orange.shade400,
                  fillGradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 252, 142, 25),
                    Color.fromARGB(255, 254, 97, 13)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  backgroundColor: const Color.fromARGB(255, 227, 227, 238),
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  width: 150,
                  height: 150,
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  onComplete: () {
                    if (question_count + 1 < qustion_data.length) {
                      setState(() {
                        isPlaying = false;
                      });
                    }
                  },
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  isPlaying
                      ? ""
                      : isCorrect
                          ? "\u{1F680} Correct \n  Correct Answer : ${unescape.convert(qustion_data[question_count].correct_answer)}"
                          : "\u{274c} Wrong \n Correct Answer : ${unescape.convert(qustion_data[question_count].correct_answer)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isPlaying ? Colors.transparent : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(
                  flex: 1,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: GetPlatform.isWeb
                          ? html.window.navigator.userAgent.contains('Mobile')
                              ? (5 / 2)
                              : (5 / 1)
                          : (5 / 2),
                      crossAxisCount: 2),
                  itemCount: nowQuestion.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          if (isPlaying) {
                            setState(() {
                              if (question_count + 1 == qustion_data.length) {
                                gameEnd = true;
                              }
                              select = true;
                              yourSelect = index;
                              isPlaying = false;
                              if (nowQuestion[yourSelect] ==
                                  qustion_data[question_count].correct_answer) {
                                isCorrect = true;
                                context.read<Category>().addScore();
                              }
                              _controller.pause();
                            });
                          }
                        },
                        child: Container(
                          decoration: !isPlaying
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: gameStatus[index]
                                      ? Border.all(
                                          color: Colors.blue.shade200, width: 4)
                                      : null,
                                  color: select
                                      ? yourSelect == index
                                          ? Colors.red[200]
                                          : Colors.white
                                      : Colors.white)
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                          child: Center(
                            child: AutoSizeText(
                              unescape.convert(nowQuestion[index]),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                !isPlaying
                    ? !gameEnd
                        ? TextButton(
                            onPressed: () {
                              question_count++;
                              nextQuestion();
                            },
                            child: const Text("Next Question"))
                        : TextButton(
                            onPressed: () {
                              context.read<Category>().setQuestionsNum(
                                  qustion_data.length.toString());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EndingScreen(),
                                  ));
                            },
                            child: const Text("Check Score"))
                    : const SizedBox(),
                const Spacer(
                  flex: 1,
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
