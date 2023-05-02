import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/widgets/task_list.dart';
import 'package:provider/provider.dart';

class QuadrantDetailScreen extends StatelessWidget {
  final int quadrant;

  const QuadrantDetailScreen({required this.quadrant, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final List<Task> quadrantTasks = tasksProvider.getTasksByQuadrant(quadrant);

    return Scaffold(
      appBar: AppBar(
        title: Text('象限 $quadrant'),
      ),
      body: Hero(
        tag: 'quadrant-$quadrant',
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.blue.shade200,
              ),
              child: TaskList(tasks: quadrantTasks),
            ),
          ),
        ),
      ),
    );
  }
}
