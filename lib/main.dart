import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TasksProvider(),
      child: MaterialApp(
        title: 'Quadrant Master',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
