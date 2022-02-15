import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebsafeSvg.asset('assets/icons/bg.svg',
              fit: BoxFit.fill, width: double.infinity),
          Column(
            children: [
              const Spacer(flex: 3),
              Text('Score', style: Theme.of(context).textTheme.headline3?.copyWith(color: kSecondaryColor),),
              const Spacer(),
              Text('${_controller.numOfCorrectAns *10}/${_controller.questions.length *10}', style: Theme.of(context).textTheme.headline4?.copyWith(color: kSecondaryColor),),
              const Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}