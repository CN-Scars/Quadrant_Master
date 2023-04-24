import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/edit_task_screen.dart';
import 'package:quadrant_master/widgets/task_list.dart';

class QuadrantDetailScreen extends StatelessWidget {
  final int quadrant;

  QuadrantDetailScreen({required this.quadrant});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final List<Task> tasks = tasksProvider.getUnarchivedTasksByQuadrant(quadrant);

    return Scaffold(
      appBar: AppBar(
        title: Text('象限 $quadrant'),
      ),
      body: TaskList(tasks: tasks),
    );
  }
}
