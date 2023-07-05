import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/widgets/task_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final List<Task> completedTasks = tasksProvider.getCompletedTasks();
    final colorScheme = Theme.of(context).colorScheme; // 获取当前主题的颜色

    return Scaffold(
      appBar: AppBar(
        title: Text('已归档任务'),
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.4), // 使用当前主题的主要颜色作为背景色，并设置透明度
          ),
          child: TaskList(tasks: completedTasks),
        ),
      ),
    );
  }
}
