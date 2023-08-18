import 'package:flutter/material.dart';
import 'package:question_game/data/provider/Category.dart';
import 'package:provider/provider.dart';
import 'package:question_game/screen/category/categroy_screen.dart';
import 'package:question_game/screen/category/difficulty_screen.dart';
import 'package:question_game/screen/category/size_screen.dart';
import 'package:question_game/screen/category/type_screen.dart';
import 'package:question_game/screen/game/game.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Category()),
    ],
    child: const MaterialApp(home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 게임 실행 시 게임 데이터 저장
  startGame() {
    final tp = context.read<Category>().type;
    final dc = context.read<Category>().difficulty;
    final idx = context.read<Category>().ctIndex;
    final cnt = context.read<Category>().size;

    String path = "";

    // 문제 개수 확인
    path += "?amount=$cnt";

    // 카테코리 확인
    // idx = 0 -> 랜덤 타입
    if (idx != "0") path += "&category${int.parse(idx) + 8}";

    // 난이도
    if (dc != 'Any Difficulty') path += '&difficulty=${dc.toLowerCase()}';

    // 문제 타입
    if (tp == 'Multiple Choice') {
      path += '&type=multiple';
    } else if (tp == 'True False') {
      path += '&type=boolean';
    }

    context.read<Category>().setPath(path);
    context.read<Category>().setScore("0");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GameScreen(),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Spacer(
          flex: 8,
        ),
        const CategoryScreen(),
        const DifficultyScreen(),
        const TypeScreen(),
        const SizeScreen(),
        const Spacer(
          flex: 2,
        ),
        TextButton(
            onPressed: () {
              startGame();
            },
            child: Card(
              color: Colors.transparent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Container(
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
                    "Start Game",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
        const Spacer(
          flex: 6,
        ),
      ],
    ));
  }
}
