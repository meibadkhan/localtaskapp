import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app_providers/task_provider.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          Text(
            "Sort by: ",
            style: GoogleFonts.roboto().copyWith(fontSize: 15.sp),
          ),
          Consumer<TaskProvider>(
            builder: (context, provider, child) {
              return ToggleButtons(
                isSelected: [

                  provider.selectedFilter == 'Completed',
                  provider.selectedFilter == 'Pending',
                ],
                onPressed: (index) {
                  if (index == 0) {
                    provider.filterByCompletionStatus(true); // Filter by Completed
                    provider.setSelectedFilter('Completed');
                  } else if (index == 1) {
                    provider.filterByCompletionStatus(false); // Filter by Pending
                    provider.setSelectedFilter('Pending');
                  }
                },
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: const Color(0xffadbce6), // Button color when selected
                color: Colors.black87,
                selectedBorderColor: const Color(0xffadbce6),
                borderColor: Colors.grey.shade300,
                children: [

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Text(
                      'Complete',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Text(
                      'Pending',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

