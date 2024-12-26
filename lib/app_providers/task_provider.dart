import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:intl/intl.dart';

import '../app_models/task_model.dart';
import '../app_screens/home_screens/home_screen.dart';
import '../app_service/db_service.dart';
import '../app_service/local_notification.dart';


class TaskProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final NotificationService _notificationService = NotificationService();

  List<Task> taskData = [];
  List<Task> filteredTaskData =[] ;
  File? file;
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescriptions = TextEditingController();

  /// Fetch tasks from local database
  Future<void> getTasks() async {
    try {
      taskData = await _dbHelper.getAllTasks();
      filteredTaskData = taskData; // Initialize filtered list with all tasks
      selectedFilter='';
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  /// Search tasks
  void searchTask(String query) {
    if (query.isEmpty) {
      filteredTaskData = taskData; // Reset to all tasks if query is empty
      selectedFilter = '';
    } else {
      filteredTaskData = taskData.where((task) {
        final taskNameLower = task.taskName.toLowerCase();
        final searchLower = query.toLowerCase();
        return taskNameLower.contains(searchLower);
      }).toList();
    }
    notifyListeners();
  }


  String selectedFilter = '';

  List<Task> get tasks => filteredTaskData.isEmpty ? taskData : filteredTaskData;

  void setSelectedFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }



  void filterByCompletionStatus(bool isComplete) {
    filteredTaskData = taskData.where((task) => task.isComplete == isComplete).toList();
    notifyListeners();
  }

  void resetFilters() {

    filteredTaskData.clear();

    notifyListeners();
  }

  void loadTasks(List<Task> tasks) {
    filteredTaskData = tasks;
    resetFilters();
  }



  /// Update task status
  Future<int> updateTask(Task task) async {
    return await _dbHelper.updateTask(task).whenComplete((){
      getTasks();
    });
  }

  /// Update task status
  Future<int>   uploadTask(Task task) async {
  return  await _dbHelper.insertTask(task).whenComplete((){
    getTasks();
  });


  }


  /// Delete task
  void deleteTask(int taskId) async {
    await _notificationService.cancelNotification(taskId);

    await _dbHelper.deleteTask(taskId);
    getTasks();
  }

  /// complete task
  void completeTask(Task task) async {
    task.isComplete=true;
    await _dbHelper.updateTask(task);
    getTasks();
  }


  /// Add new task
  void addTask() async {
    Task task = Task(
      taskName: taskName.text,
      description: taskDescriptions.text,
      dateAdded: DateTime.now().toString()
    );
    await _dbHelper.insertTask(task);
    getTasks();
  }

  /// Show info message
  void showInfo(String msg, Color color) {
    Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  /// Show loader
  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator(),),
              Text("Please Wait....")
            ],
          ),
        );
      },
    );
  }

  /// Update UI
  void updateState() {
    notifyListeners();
  }

   DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {

        selectedDate = pickedDate;
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {

        selectedTime = pickedTime;
        notifyListeners();
    }
  }

  String getFormattedDateTime() {
    if (selectedDate != null && selectedTime != null) {
      final DateTime combinedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      return DateFormat('yyyy-MM-dd HH:mm').format(combinedDateTime);
    }
    return DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }
  saveAndUpdate(bool isUpdate, Task task, BuildContext context) async {
    if (taskName.text.isEmpty) {
      showInfo("Task Name is required", Colors.black);
      return;
    }

    if (taskDescriptions.text.isEmpty) {
      showInfo("Task Description is required", Colors.black);
      return;
    }

    if (selectedDate == null || selectedTime == null) {
      showInfo("Date and Time are required", Colors.black);
      return;
    }

    // Combine date and time
    final DateTime scheduledDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );


    try {

      if (_notificationService == null) {
        throw Exception("Notification service is not initialized.");
      }

      // Schedule notification

      showLoader(context);

      if (isUpdate) {
        // Update task
        await updateTask(
          Task(
            id: task.id,
            taskName: taskName.text,
            description: taskDescriptions.text,
            dateAdded: getFormattedDateTime(),
          ),
        ).then((c)async {
          await _notificationService.scheduleTaskNotification(
            id: c,
            title: 'Reminder: ${task.taskName}',
            body: task.description,
            scheduledDate: scheduledDateTime,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${task.taskName} is updated')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (predicate) => false,
          );
          clearFields();
        });
      } else {
        // Upload task
        await uploadTask(
          Task(
            taskName: taskName.text,
            description: taskDescriptions.text,
            dateAdded: getFormattedDateTime(),
          ),

        ).then((c) async{
          await _notificationService.scheduleTaskNotification(
            id: c,
            title: 'Reminder: ${taskName.text}',
            body: taskDescriptions.text,
            scheduledDate: scheduledDateTime,
          );


          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (predicate) => false,
          );
          clearFields();
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    }
  }

// Helper method to clear input fields
  void clearFields() {
    taskName.clear();
    taskDescriptions.clear();
    selectedDate = null;
    selectedTime = null;
  }

  // saveAndUpdate(isUpdate,Task task,context)async{
  //   if (taskName.text.isEmpty) {
  //     showInfo("Task Name is required", Colors.black);
  //   } else if (taskDescriptions.text.isEmpty) {
  //     showInfo("Task Description is required", Colors.black);
  //   } else if (selectedDate == null || selectedTime == null) {
  //     showInfo("Date and Time are required", Colors.black);
  //   } else {
  //     // Combine date and time
  //     final DateTime scheduledDateTime = DateTime(
  //       selectedDate!.year,
  //       selectedDate!.month,
  //       selectedDate!.day,
  //       selectedTime!.hour,
  //       selectedTime!.minute,
  //     );
  //
  //     // Create or update task
  //     await _notificationService.scheduleTaskNotification(
  //       id: task.id!,
  //       title: 'Task Reminder: ${task.taskName}',
  //       body: task.description,
  //       scheduledDate: scheduledDateTime,
  //     );
  //
  //     showLoader(context);
  //     isUpdate
  //         ? updateTask(
  //       Task(
  //         id: task.id,
  //         taskName: taskName.text,
  //         description: taskDescriptions.text,
  //         dateAdded: getFormattedDateTime(),
  //       ),
  //     ).whenComplete(() {
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('${task.taskName} is updated')),
  //       );
  //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
  //           (context)=>const HomeScreen())
  //           , (predicate)=>false);
  //       taskName.clear();
  //       taskDescriptions.clear();
  //       selectedDate=null;
  //       selectedTime=null;
  //     })
  //         : uploadTask(
  //       Task(
  //         taskName: taskName.text,
  //         description: taskDescriptions.text,
  //         dateAdded: getFormattedDateTime(),
  //       ),
  //     ).whenComplete(() {
  //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
  //           (context)=>const HomeScreen())
  //           , (predicate)=>false);
  //   taskName.clear();
  //       taskDescriptions.clear();
  //       selectedDate=null;
  //       selectedTime=null;
  //     });
  //   }
  // }
updateFields(isUpdate,Task task){

  if (isUpdate) {

    taskName.text = task.taskName;
    taskDescriptions.text = task.description;
    selectedDate = DateTime.parse(task.dateAdded);
    selectedTime = TimeOfDay.fromDateTime(DateTime.parse(task.dateAdded));
notifyListeners();
  }
}
}