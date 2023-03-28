import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/custom_text.dart';
import 'package:todo_app/progress_slider.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color.fromARGB(255, 24, 59, 109)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Task Details",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 24, 59, 109),
                ),
              )),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Web Development",
                size: 20,
                weight: FontWeight.w600,
                color: Color.fromARGB(255, 24, 59, 109),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 57, 67, 111),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                      text: "04 April, at 11:30 AM",
                      size: 15,
                      weight: FontWeight.w400,
                      color: Color.fromARGB(255, 47, 63, 82))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const ProgressSlider(percentage: 80, dark: true),
              const SizedBox(
                height: 30,
              ),
              const CustomText(
                text: "Overview",
                size: 20,
                weight: FontWeight.w600,
                color: Color.fromARGB(255, 24, 59, 109),
              ),
              const Flexible(
                child: CustomText(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu dapibus turpis, eu tincidunt augue. Nunc vehicula dictum augue, quis ullamcorper purus eleifend at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse aliquam blandit tellus, ac porttitor nunc faucibus vitae. Etiam non aliquam magna, ac volutpat quam. Donec sed fringilla elit. Curabitur ac congue nisl. Mauris consectetur a turpis sit amet lobortis. Vestibulum finibus tincidunt ex, sit amet congue odio viverra vitae. Sed consequat et elit eu sodales. Nunc consectetur mi arcu, convallis accumsan metus luctus ut. Suspendisse vitae libero ac nisl porttitor interdum. Duis ut odio vel nisl cursus ultricies. Donec tempus aliquam cursus. Nullam vulputate nibh ac consectetur auctor. Sed quis volutpat mi, nec aliquet nunc. Etiam hendrerit varius ultrices. Donec non aliquam quam. Nunc a tempor libero. Nulla eleifend commodo rutrum. Vivamus consectetur nulla vel diam mollis dictum. Cras scelerisque auctor venenatis.",
                  size: 14,
                  weight: FontWeight.w400,
                  color: Color.fromARGB(255, 98, 127, 167),
                ),
              )
            ],
          ),
        ));
  }
}
