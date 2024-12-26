import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
 import 'package:responsive_sizer/responsive_sizer.dart';

import '../../app_helpers/asset_helper.dart';


class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xffF2F5FF),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('EEEE').format(DateTime.now()),
              style: GoogleFonts.robotoSerif().copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          Text(
            DateFormat('MMM dd, yyyy').format(DateTime.now()),
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(AssetHelper.bg),
            child: Icon(Icons.person, color: Colors.white,),
          ),
        )
        // FilterButton()
      ],
    );
  }
}

