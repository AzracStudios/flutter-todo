import 'package:flutter/material.dart';

class ValidatedField extends StatefulWidget {
  const ValidatedField(
      {super.key,
      required this.ctrl,
      required this.ln,
      required this.onValueChange,
      this.error});

  final TextEditingController ctrl;
  final int ln;

  final Function(String) onValueChange;
  final String? error;

  @override
  State<ValidatedField> createState() => _ValidatedFieldState();
}

class _ValidatedFieldState extends State<ValidatedField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.ctrl,
      onChanged: (val) => widget.onValueChange(val),
      maxLines: widget.ln,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: '',
        errorText: widget.error,
      ),
      style: const TextStyle(
        color: Color.fromARGB(255, 24, 59, 109),
      ),
    );
  }
}
