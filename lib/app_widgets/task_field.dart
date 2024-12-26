import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskField extends StatelessWidget {
  TaskField({
    super.key,
    this.controller,this.hintText,this.maxLine=1
  });

  String? hintText;
  TextEditingController? controller;
  int? maxLine;
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
        style: GoogleFonts.roboto().copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        maxLines: maxLine,

        controller:controller,
        decoration: InputDecoration(
        fillColor: Colors.white,
            prefixIcon:maxLine==1? const Icon(Icons.person,color:
            Colors.grey,size: 20,):const Icon(Icons.description,color:
            Colors.grey,size: 20,),
          filled: true,
          hintText: hintText,
          contentPadding:   EdgeInsets.only(top: maxLine==1?15:18),
          hintStyle: GoogleFonts.roboto().copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
          border: InputBorder.none
        )
      ),
    );
  }
}
