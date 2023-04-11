import 'package:flutter/material.dart';
import '../../shared/text.dart';
import '../../theme.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.errorStream,
    required this.ctrl,
    this.validate,
    required this.lable,
    required this.ln,
    required this.onValueChange,
  });

  final Stream<String?> errorStream;
  final TextEditingController ctrl;
  final void validate;
  final String lable;
  final int ln;

  final Function(String) onValueChange;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.lable,
          size: 20,
          weight: FontWeight.w600,
          color: const Color.fromARGB(255, 24, 59, 109),
        ),
        StreamBuilder<String?>(
            stream: widget.errorStream,
            builder: (context, snapshot) {
              String? error = snapshot.data;

              return TextField(
                  controller: widget.ctrl,
                  onChanged: (val) => widget.onValueChange(val),
                  maxLines: widget.ln,
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderRadius: AppTheme.borderRadius),
                    labelText: '',
                    errorText: error,
                  ),
                  style: const TextStyle(
                    color: AppTheme.colorPrimary,
                  ));
            }),
      ],
    );
  }
}
