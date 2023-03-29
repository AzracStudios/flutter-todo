import 'package:flutter/material.dart';
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

  bool timeError = false;

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
    timeError = false;

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

  String? titleError;
  String? descError;

  bool titleValidate(val) {
    String? buff;

    if (val.length < 6) {
      titleError = 'Input needs atleast 6 characters';
      return true;
    }

    if (val.length > 30) {
      titleError = 'Input should be no longer than 30 characters';
      return true;
    }

    titleError = null;

    if (titleError == buff) setState(() {});
    return false;
  }

  bool descValidate(val) {
    String? buff;

    if (val.length > 300) {
      descError = 'Input should be no longer than 300 characters';
      return true;
    }

    descError = null;
    if (descError == buff) setState(() {});
    return false;
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
                ValidatedField(
                    ln: 1,
                    ctrl: titleCtrl,
                    onValueChange: (val) {
                      bool err = titleValidate(val);
                      if (err) setState(() {});
                    },
                    error: titleError),
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
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: !timeError
                                      ? const Color.fromARGB(255, 164, 164, 164)
                                      : Colors.red,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
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
                          CustomText(
                            text: timeError ? "Invalid start time" : "",
                            size: 12,
                            weight: FontWeight.w500,
                            color: Colors.red,
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
                          CustomText(
                            text: "",
                            size: 12,
                            weight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            CustomText(
              text: "Description",
              size: 20,
              weight: FontWeight.w600,
              color: const Color.fromARGB(255, 24, 59, 109),
            ),
            ValidatedField(
              ln: 2,
              ctrl: descCtrl,
              onValueChange: (val) {
                bool err = descValidate(val);
                if (err) setState(() {});
              },
              error: descError,
            ),

            const SizedBox(height: 20),

            // CREATE
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TITLE
                  bool titleErr = titleValidate(titleCtrl.text);
                  if (titleErr) return setState(() {});

                  // DESCRIPTION
                  bool descErr = titleValidate(descCtrl.text);
                  if (descErr) return setState(() {});

                  // TIME
                  int startTimeInt =
                      (startTime.hour * 60 + startTime.minute) * 60;
                  int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
                  if (startTimeInt >= endTimeInt) {
                    timeError = true;
                    return setState(() {});
                  }

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
