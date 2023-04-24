import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({required this.tasks});

  void _showArchivedSnackBar(BuildContext context, Task task, TasksProvider tasksProvider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('任务已归档: ${task.title}'),
        action: SnackBarAction(
          label: '撤销',
          onPressed: () {
            tasksProvider.toggleTaskCompletion(task.id, false);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) {
              if (value != null) {
                tasksProvider.toggleTaskCompletion(task.id, value);
                if (value) {
                  _showArchivedSnackBar(context, task, tasksProvider);
                }
              }
            },
          ),
          title: Text(task.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              Text('优先级：${task.priority.toShortString()}'),
            ],
          ),
          trailing: Text(task.dueDate.toString()),
        );
      },
    );
  }
}
