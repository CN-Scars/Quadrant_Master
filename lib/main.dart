import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/home_screen.dart';

// 将 main 函数更改为异步，并等待 tasksProvider.loadTasks() 完成
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 在使用异步方法前确保Flutter绑定初始化
  final tasksProvider = TasksProvider();
  await tasksProvider.loadTasks(); // 加载任务列表

  runApp(
    // 将 ChangeNotifierProvider 移到了 runApp 函数内，这样你可以在加载任务列表后将 tasksProvider 传递给它
    ChangeNotifierProvider(
      create: (context) => tasksProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // 移除了 const MyApp() 构造函数中的 key 参数，因为它在这里没有用处

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