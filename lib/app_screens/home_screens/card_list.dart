import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 import 'package:provider/provider.dart';

import '../../app_providers/task_provider.dart';


import '../../app_widgets/card_widget.dart';



///This is Card items List
///********************************************* Card Item List *******************************************///
class CardList extends StatelessWidget {
  const CardList({
    super.key,
    required this.provider,
  });

  final TaskProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TaskProvider>(builder: (context, mdl, _) {

        if (provider.filteredTaskData.isEmpty) {
          return const Center(
            child: Text("No Task yet!"),
          );

        }

        return ListView.builder(
          itemCount: provider.filteredTaskData.length,
          itemBuilder: (context, index) {
            final task = provider.filteredTaskData[index];
            return TaskCard(task: task,);
            return Dismissible(

              key: ValueKey(task.taskName),
              background: task.isComplete != false
                  ? null
                  : Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_box_outlined,
                      color: Colors.green,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    RotatedBox(
                      quarterTurns: 3, // Rotate by 90 degrees
                      child: Text(" Complete ",
                          style: GoogleFonts.roboto().copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.green,
                      size: 15,
                    ),
                  ],
                ),
              ),
              secondaryBackground: task.isComplete != false
                  ? null
                  : Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    RotatedBox(
                      quarterTurns: 3, // Rotate by 90 degrees
                      child: Text("  Delete  ",
                          style: GoogleFonts.roboto().copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.red,
                      size: 15,
                    ),
                  ],
                ),
              ),
              confirmDismiss: (direction) async {

                // Prevent swipe if task is accepted
                if (task.isComplete == true) {
                  return false;
                }

                if (direction == DismissDirection.startToEnd) {
                  provider.completeTask(task);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${task.taskName} marked as Completed')),
                  );

                  return false;
                } else if (direction == DismissDirection.endToStart) {
                  return true;
                }
                return false;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  provider.deleteTask(task.id!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${task.taskName} is Deleted')),
                  );
                }
              },
              child: TaskCard(task: task),
            );
          },
        );
      }),
    );
  }
}
