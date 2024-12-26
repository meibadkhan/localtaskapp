import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
 import '../app_providers/task_provider.dart';
import 'app_screens/home_screens/home_screen.dart';
import 'app_service/local_notification.dart';
main()async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications


  final NotificationService notificationService = NotificationService();
  await notificationService.init();

  // Request iOS-specific permissions
  await notificationService.requestIOSPermissions();
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
      providers: [
         ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
      ],
      child: ResponsiveSizer(
          builder: (context, orientation, screentype) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffF2F5FF)
          ),
          title: "Task App",
          home:   const HomeScreen(),
        );
        }
      ),
    );
  }
}

