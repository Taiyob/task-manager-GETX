import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager_application/controller_binder.dart';
import 'package:task_manager_application/presentation/screens/splash_screen.dart';
import 'package:task_manager_application/presentation/utils/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManager.navigatorKey,
      title: 'Task Manager',
      home: SplashScreen(),
      theme: _themeData,
      initialBinding: ControllerBinder(),
    );
  }
  final ThemeData _themeData = ThemeData(
    fontFamily: 'Roboto',
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.themeColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,fontSize: 16,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 32,fontWeight: FontWeight.w600),
      //titleMedium: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
    ),
    chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
    ),
  );
}

