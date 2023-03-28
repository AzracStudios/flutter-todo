import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_text.dart';
import 'home.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            const Gradient(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Image.asset(
                    "assets/landing.png",
                    scale: 2.2,
                  ),
                ),
                Column(
                  children: [
                    const CustomText(
                      text: "Welcome to Go Task",
                      size: 25,
                      weight: FontWeight.w600,
                      color: Color.fromARGB(255, 35, 74, 133),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0),
                        child: const CustomText(
                          text:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus congue sollicitudin dui",
                          size: 10,
                          weight: FontWeight.w600,
                          color: Color.fromARGB(255, 35, 74, 133),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Home()))
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                    child: CustomText(
                      text: "Let's Start!",
                      size: 15,
                      weight: FontWeight.w400,
                      color: Color.fromARGB(255, 238, 245, 255),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class Gradient extends StatelessWidget {
  const Gradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color(0xff3787EB),
          Color.fromARGB(255, 211, 229, 252),
          Color(0xffffffff)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    ));
  }
}
