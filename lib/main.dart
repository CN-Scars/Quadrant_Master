import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 在使用异步方法前确保Flutter绑定初始化
  final tasksProvider = TasksProvider();
  await tasksProvider.loadTasks(); // 加载任务列表

  runApp(
    ChangeNotifierProvider(
      create: (context) => tasksProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quadrant Master',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

// 在 main 函数外部添加了 WidgetsFlutterBinding.ensureInitialized() 以确保在使用异步方法前初始化 Flutter 绑定。
// 将 main 函数更改为异步，并等待 tasksProvider.loadTasks() 完成。
// 移除了 const MyApp() 构造函数中的 key 参数，因为它在这里没有用处。
// 将 ChangeNotifierProvider 移到了 runApp 函数内，这样你可以在加载任务列表后将 tasksProvider 传递给它。