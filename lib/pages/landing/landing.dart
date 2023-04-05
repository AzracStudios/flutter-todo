import 'package:flutter/material.dart';

import '../../shared/custom_text.dart';
import '../home/home.dart';

abstract class Styles {
  static List<Color> gradientColors = const <Color>[
    Color(0xff3787EB),
    Color.fromARGB(255, 211, 229, 252),
    Color(0xffffffff)
  ];
}

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gradient(),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Welcome to Go Task",
                size: 25,
                weight: FontWeight.w600,
                color: const Color.fromARGB(255, 35, 74, 133),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0),
                child: CustomText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus congue sollicitudin dui",
                    size: 10,
                    weight: FontWeight.w600,
                    color: const Color.fromARGB(255, 35, 74, 133),
                    center: true),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()))
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                  child: CustomText(
                    text: "Let's Start!",
                    size: 15,
                    weight: FontWeight.w400,
                    color: const Color.fromARGB(255, 238, 245, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Gradient extends StatelessWidget {
  const Gradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: Styles.gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/landing.png",
            scale: 2.5,
          ),
        ),
      ),
    );
  }
}
