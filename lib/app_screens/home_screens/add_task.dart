import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../app_helpers/constant.dart';
import '../../app_models/task_model.dart';
import '../../app_providers/task_provider.dart';
import '../../app_widgets/floating_button.dart';
import '../../app_widgets/task_field.dart';
import '../../app_widgets/time_date.dart';

class AddTaskScreen extends StatefulWidget {
  final bool isUpdate;
  final Task task;

  const AddTaskScreen({Key? key, required this.isUpdate, required this.task})
      : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TaskProvider>(context, listen: false);
      provider.updateFields(widget.isUpdate, widget.task);
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color(0xffF2F5FF),
        title: Text(widget.isUpdate ? 'Update Task' : 'Add Task'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context,mdl,_) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  TaskField(
                    controller:provider.taskName,
                    hintText: "Enter Task Name",
                  ),
                  kheightBoxed(),
                  TaskField(
                    controller: provider.taskDescriptions,
                    hintText: "Enter Description",
                    maxLine: 2,
                  ),
                  kheightBoxed(),
                  Row(
                    children: [
                      Expanded(
                        child: SelectDate(provider: provider),
                      ),
                      const SizedBox(width: 16),
                      Expanded(

                        child: SelectTime(provider: provider),
                      ),
                    ],
                  ),
                  kheightBoxed(),
                  kheightBoxed(),
                  kheightBoxed(),
                  FloatingButton(
                    width: double.infinity,
                    onTap: () {
                      provider.saveAndUpdate(widget.isUpdate, widget.task, context);
                    },
                    text: widget.isUpdate ? 'Update' : "Save",
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
