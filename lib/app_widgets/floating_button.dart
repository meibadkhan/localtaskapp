
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app_helpers/asset_helper.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.onTap,this.text,this.color,this.width
  });
  final VoidCallback? onTap;
final String? text;
final Color? color;
final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap:onTap,
      child: Container(
          width:width?? 150,
          height: 40,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
              color: color,
              boxShadow:[
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  // Shadow position
                ),
              ],
              image:color==null?const DecorationImage(image: AssetImage(AssetHelper.bg),fit: BoxFit.cover):null
          ),
          child:  Center(child:  Text(text??"+ Add New Task",style: GoogleFonts.roboto().copyWith(fontWeight: FontWeight.bold,),),)
      ),
    );
  }
}
