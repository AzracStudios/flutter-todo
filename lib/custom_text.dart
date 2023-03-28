import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.size,
    required this.weight,
    required this.color,
  });

  final String text;
  final double size;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 5,
      style: GoogleFonts.getFont(
        "Poppins",
        textStyle: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
