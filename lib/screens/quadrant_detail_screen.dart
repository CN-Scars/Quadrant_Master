import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/widgets/task_list.dart';
import 'package:provider/provider.dart';

class QuadrantDetailScreen extends StatelessWidget {
  final int quadrant;

  const QuadrantDetailScreen({required this.quadrant, Key? key})
      : super(key: key);

  String getQuadrantTitle(int quadrant) {
    switch (quadrant) {
      case 1:
        return '重要且紧急';
      case 2:
        return '重要不紧急';
      case 3:
        return '紧急不重要';
      case 4:
        return '不重要且不紧急';
      default:
        return '未知象限';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final List<Task> quadrantTasks = tasksProvider.getTasksByQuadrant(quadrant);
    final colorScheme = Theme.of(context).colorScheme; // 获取当前主题的颜色

    return Scaffold(
      appBar: AppBar(
        title: Text(getQuadrantTitle(quadrant)),
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
                color: colorScheme.primary.withOpacity(0.4),
                // color: Colors.blue.shade200,
              ),
              child: TaskList(tasks: quadrantTasks),
            ),
          ),
        ),
      ),
    );
  }
}
