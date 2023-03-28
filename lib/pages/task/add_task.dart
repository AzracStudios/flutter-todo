import 'package:flutter/material.dart';
import 'package:todo_app/shared/text_controller.dart';
import 'package:todo_app/shared/validated_field.dart';
import 'package:todo_app/shared/custom_text.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  String formError = "";

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ).then((value) {
      setState(() {
        selectedDate = value!;
      });
    });
  }

  void selectTime(bool isStart) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (isStart) {
          startTime = value!;
        } else {
          endTime = value!;
        }
      });
    });
  }

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
        title: CustomText(
          text: "Add Task",
          size: 20,
          weight: FontWeight.w600,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TITLE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Title",
                  size: 20,
                  weight: FontWeight.w600,
                  color: const Color.fromARGB(255, 24, 59, 109),
                ),
                ValidatedField(min: 6, max: 30, ln: 1, ctrl: titleCtrl),
              ],
            ),

            const SizedBox(height: 10),

            // DATE AND TIME
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Date & Time",
                  size: 20,
                  weight: FontWeight.w600,
                  color: const Color.fromARGB(255, 24, 59, 109),
                ),
                Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 164, 164, 164),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                    child: ListTile(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      onTap: () => selectDate(),
                      title: CustomText(
                        text: selectedDate.toString().split(" ")[0],
                        size: 16,
                        weight: FontWeight.w500,
                        color: const Color.fromARGB(255, 24, 59, 109),
                      ),
                      trailing: const Icon(Icons.calendar_month_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Start Time",
                            size: 20,
                            weight: FontWeight.w600,
                            color: const Color.fromARGB(255, 24, 59, 109),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            child: Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                                child: ListTile(
                                  hoverColor: Colors.white,
                                  focusColor: Colors.white,
                                  onTap: () => selectTime(true),
                                  title: CustomText(
                                    text: startTime.format(context).toString(),
                                    size: 15,
                                    weight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 24, 59, 109),
                                  ),
                                  trailing:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "End Time",
                            size: 20,
                            weight: FontWeight.w600,
                            color: const Color.fromARGB(255, 24, 59, 109),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            child: Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Color.fromARGB(255, 164, 164, 164),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                                child: ListTile(
                                  hoverColor: Colors.white,
                                  focusColor: Colors.white,
                                  onTap: () => selectTime(false),
                                  title: CustomText(
                                    text: endTime.format(context).toString(),
                                    size: 15,
                                    weight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 24, 59, 109),
                                  ),
                                  trailing:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // DESCRIPTION
            CustomText(
              text: "Description",
              size: 20,
              weight: FontWeight.w600,
              color: const Color.fromARGB(255, 24, 59, 109),
            ),
            ValidatedField(min: 0, max: 300, ln: 2, ctrl: descCtrl),

            const SizedBox(height: 20),

            CustomText(
                text: formError,
                size: 13,
                weight: FontWeight.w400,
                color: Colors.redAccent),

            const SizedBox(height: 20),

            // CREATE
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TITLE
                  int titleCheck = TextController.validate(6, 30, titleCtrl);

                  if (titleCheck >= 0) {
                    formError =
                        titleCheck == 0 ? "Title too short" : "Title too long";
                    return setState(() {});
                  }

                  // DESCRIPTION
                  int descCheck = TextController.validate(6, 30, titleCtrl);

                  if (descCheck >= 0) {
                    formError = "Description too long";
                    return setState(() {});
                  }

                  // TIME
                  int startTimeInt =
                      (startTime.hour * 60 + startTime.minute) * 60;
                  int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
                  if (startTimeInt >= endTimeInt) {
                    formError =
                        "Start time is the same or greater than end time";
                    return setState(() {});
                  }

                  // TODO: Create the item
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                  child: CustomText(
                    text: "Create",
                    size: 15,
                    weight: FontWeight.w400,
                    color: const Color.fromARGB(255, 238, 245, 255),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
