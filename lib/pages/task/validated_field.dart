import 'package:flutter/material.dart';
import 'package:todo_app/pages/task/text_controller.dart';

class ValidatedField extends StatefulWidget {
  const ValidatedField(
      {super.key, required this.min, required this.max, required this.ctrl, required this.ln});

  final TextEditingController ctrl;
  final int min;
  final int max;
  final int ln;

  @override
  State<ValidatedField> createState() => _ValidatedFieldState();
}

class _ValidatedFieldState extends State<ValidatedField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.ctrl,
      onChanged: (val) => setState(() {}),
      maxLines: widget.ln,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: '',
        errorText: TextController.validate(widget.min, widget.max, widget.ctrl),
      ),
      style: const TextStyle(
        color: Color.fromARGB(255, 24, 59, 109),
      ),
    );
  }
}
