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

    return Scaffold(
      appBar: AppBar(
        title: Text('已归档任务'),
      ),
      body: TaskList(tasks: completedTasks),
    );
  }
}
