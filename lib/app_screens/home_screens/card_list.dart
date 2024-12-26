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

          },
        );
      }),
    );
  }
}
