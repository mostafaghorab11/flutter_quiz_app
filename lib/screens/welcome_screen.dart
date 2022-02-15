import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebsafeSvg.asset('assets/icons/bg.svg' , fit: BoxFit.fill, width: double.infinity),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Text(
                  "Let's play Quiz,",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Text('Enter your information below'),
                const Spacer(),
                const TextField(
                    decoration: InputDecoration(
                  hintText: 'Full Name',
                  fillColor: Color(0xFF1C2341),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                )),
                const Spacer(),
                InkWell(
                  onTap: () => Get.to(() => const QuizScreen()),
                  child: Container(
                    padding: const EdgeInsets.all(kDefaultPadding * .75),
                    // 15
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Let\'s Start Quiz',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
