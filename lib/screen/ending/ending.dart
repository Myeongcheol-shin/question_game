import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_game/data/provider/Category.dart';
import 'package:question_game/main.dart';

class EndingScreen extends StatefulWidget {
  const EndingScreen({super.key});

  @override
  State<EndingScreen> createState() => _EndingScreenState();
}

class _EndingScreenState extends State<EndingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Score",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
        body: SizedBox(
          width: double.infinity,
          child: Column(children: [
            const Spacer(
              flex: 3,
            ),
            const Text(
              "Your Score !! \u{1F60F}",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.read<Category>().score,
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade400),
                ),
                const Text(
                  " / ",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                Text(
                  context.read<Category>().questionsNum,
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade400),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 252, 142, 25),
                    Color.fromARGB(255, 254, 97, 13)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    "Go to Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            )
          ]),
        ),
      ),
    );
  }
}
