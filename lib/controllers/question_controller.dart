import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/score_screen.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sampleData
      .map(
        (question) => Question(
          question['id'],
          question['question'],
          question['options'],
          question['answer_index'],
        ),
      )
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  late int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // our animation duration is 60s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // once 60s is completed go the the next question
    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();

    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    _pageController.dispose();
    super.onClose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if(_selectedAns == _correctAns){
      _numOfCorrectAns++;
      // it will stop the progressbar
      _animationController.stop();
      update();

      // once user select an ans after 3s it will go to the next question
      Future.delayed(const Duration(seconds: 2), () {
        nextQuestion();
      });
    } else {
      _animationController.stop();
      update();
      Future.delayed(const Duration(seconds: 2), () => nextQuestion());
    }
  }

  void nextQuestion() {
    if(_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // reset the counter
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(() => const ScoreScreen());
    }
  }

  void updateQuestionNumber(int index) {
    _questionNumber.value = index +1;
  }
}
