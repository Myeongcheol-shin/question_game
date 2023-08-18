import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  String _category = "Any Category";
  String get category => _category;

  String _ctIndex = "0";
  String get ctIndex => _ctIndex;

  String _difficulty = "Any Difficulty";
  String get difficulty => _difficulty;

  String _type = "Any Type";
  String get type => _type;

  String _size = "5";
  String get size => _size;

  String _path = "";
  String get path => _path;

  String _score = "";
  String get score => _score;

  String _questionsNum = "";
  String get questionsNum => _questionsNum;

  void initItem() {
    _category = "Any Category";
    _difficulty = "Any Difficulty";
    _type = "Any Type";
    _size = "5";
    _path = "";
  }

  void addScore() {
    _score = (int.parse(_score) + 1).toString();
  }

  void setQuestionsNum(String question) {
    _questionsNum = question;
    notifyListeners();
  }

  void setScore(String score) {
    _score = score;
    notifyListeners();
  }

  void setPath(String path) {
    _path = path;
    notifyListeners();
  }

  void setSize(String size) {
    _size = size;
    notifyListeners();
  }

  void setIndex(String index) {
    _ctIndex = index;
    notifyListeners();
  }

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }

  void setDifficulty(String difficulty) {
    _difficulty = difficulty;
    notifyListeners();
  }

  void setType(String type) {
    _type = type;
    notifyListeners();
  }
}
