import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../app_providers/task_provider.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
    super.key,
    required this.provider,
  });

  final TaskProvider provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => provider.selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.grey,size: 20,),
            const SizedBox(width: 8),
            Text(
              provider.selectedDate == null
                  ? "Select Date"
                  : DateFormat('dd-MM-yyyy').format(provider.selectedDate!),
              style: GoogleFonts.roboto().copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatelessWidget {
  const SelectTime({
    super.key,
    required this.provider,
  });

  final TaskProvider provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () => provider.selectTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Colors.grey,size: 20,),
            const SizedBox(width: 8),
            Text(
              provider.selectedTime == null
                  ? "Select Time"
                  : "${provider.selectedTime!.hour}:${provider.selectedTime!.minute.toString().padLeft(2, '0')}",
              style: GoogleFonts.roboto().copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}