import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/custom_text.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
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

    void setStartTime() {
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((value) {
        setState(() {
          startTime = value!;
        });
      });
    }

    void setEndTime() {
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((value) {
        setState(() {
          endTime = value!;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(255, 24, 59, 109)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const CustomText(
          text: "Add Task",
          size: 20,
          weight: FontWeight.w600,
          color: Color.fromARGB(255, 24, 59, 109),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // TITLE
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(
                  text: "Title",
                  size: 20,
                  weight: FontWeight.w600,
                  color: Color.fromARGB(255, 24, 59, 109),
                ),
                TextField(
                    maxLength: 30,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: '',
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 24, 59, 109))),
              ],
            ),

            const SizedBox(height: 10),

            // DATE AND TIME
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Date & Time",
                  size: 20,
                  weight: FontWeight.w600,
                  color: Color.fromARGB(255, 24, 59, 109),
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
                          const CustomText(
                            text: "Start Time",
                            size: 20,
                            weight: FontWeight.w600,
                            color: Color.fromARGB(255, 24, 59, 109),
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
                                  onTap: () => setStartTime(),
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
                          const CustomText(
                            text: "End Time",
                            size: 20,
                            weight: FontWeight.w600,
                            color: Color.fromARGB(255, 24, 59, 109),
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
                                  onTap: () => setEndTime(),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(
                  text: "Description",
                  size: 20,
                  weight: FontWeight.w600,
                  color: Color.fromARGB(255, 24, 59, 109),
                ),
                TextField(
                  maxLength: 300,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: '',
                  ),
                  style: TextStyle(color: Color.fromARGB(255, 24, 59, 109)),
                ),
              ],
            ),

            ElevatedButton(
              //TODO: IMPL SUBMIT
              onPressed: () => {Navigator.of(context).pop()},
              child: const Padding(
                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: CustomText(
                  text: "Create",
                  size: 15,
                  weight: FontWeight.w400,
                  color: Color.fromARGB(255, 238, 245, 255),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
