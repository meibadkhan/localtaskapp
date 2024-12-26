import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  CustomTextField({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 4), // Shadow position
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 4), // Shadow position
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 4), // Shadow position
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged, // Add onChanged here
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          filled: true,
          hintStyle: GoogleFonts.roboto().copyWith(color: Colors.grey),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search Task.....',
        ),
      ),
    );
  }
}
