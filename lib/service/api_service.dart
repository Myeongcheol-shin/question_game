import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:question_game/model/question.dart';

class ApiServcie {
  static String url = "https://opentdb.com/api.php";

  Future<List<Question>> getQuestion(String path) async {
    final furl = Uri.parse("$url/$path");
    List<Question> questionInstances = [];
    final response = await http.get(furl);
    if (response.statusCode == 200) {
      final jd = jsonDecode(response.body);

      if (jd["response_code"] == 0) {
        List<dynamic> questions = jd['results'];
        for (var question in questions) {
          questionInstances.add(Question.fromJson(question));
        }
        return questionInstances;
      }
    }
    throw Error;
  }
}
