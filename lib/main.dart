import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/task.dart';
import 'package:flutter_application_1/data/task_type.dart';
import 'package:flutter_application_1/data/type_enum.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  // ignore: unused_local_variable
  var box = await Hive.openBox('names');

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'GB',
            fontSize: 16,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
