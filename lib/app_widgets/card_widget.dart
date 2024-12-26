 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task1/app_screens/home_screens/add_task.dart';
import '../app_models/task_model.dart';

import '../app_helpers/asset_helper.dart';
import '../app_helpers/constant.dart';
 import '../app_providers/task_provider.dart';
 import 'floating_button.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage(AssetHelper.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: task.isComplete?null: (){
          showDialog(context: context, builder: (builder){
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingButton(
                    text: 'Complete',
                    onTap: (){
                      provider.completeTask(task);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${task.taskName} marked as Completed')),
                      );
                    },
                    color:Colors.green ,
                    width: double.infinity,
                  ),
                  kheightBoxed(),
                  FloatingButton(
                    width: double.infinity,
                    text: 'Update',
                    onTap: (){
                      Navigator.pop(context);

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen(isUpdate: true,
                          task: task)));
                  // provider.sheet(context,true,task);
                    },

                  ),kheightBoxed(),
                  FloatingButton(width: double.infinity,

                    text: 'Delete',
                    onTap: (){
                      provider.deleteTask(task.id!);
Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${task.taskName} is Deleted')),
                      );
                    },
                    color:Colors.red ,
                  ),
                ],
              ),
            );
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 12,right: 12,left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        task.taskName,
                        style: GoogleFonts.roboto().copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Row(

                        children: [
                        const Icon(Icons.date_range_outlined,size: 15,),
          Text("${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.parse(task.dateAdded))}",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],)

                    ],
                  ),

                ],
              ),
              kheightBoxed(),
              Text("Description:",style:GoogleFonts.roboto().copyWith(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.sp),),
              Text(task.description,style:GoogleFonts.roboto().copyWith(
                fontSize: 15.sp,
              ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),


              kheightBoxed(),
              task.isComplete==true ?Center(
                child: Container(
                  width: 150,

                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6))
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Completed ",style: TextStyle(color: Colors.green),),
                          Icon(Icons.check_box_outlined,size: 16,color: Colors.green,)
                        ],
                      ),
                    ),
                  ),
                ),
              ):const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
