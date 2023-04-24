import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

// TaskList类用于显示任务列表
class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({required this.tasks});

  // _showArchivedSnackBar方法用于显示任务已归档的SnackBar
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

  // _showUnarchivedSnackBar方法用于显示任务已恢复为未完成状态的SnackBar
  void _showUnarchivedSnackBar(BuildContext context, Task task, TasksProvider tasksProvider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('任务已恢复为未完成状态: ${task.title}'),
        action: SnackBarAction(
          label: '撤销',
          onPressed: () {
            tasksProvider.toggleTaskCompletion(task.id, true);
          },
        ),
      ),
    );
  }

  // build方法用于构建任务列表的UI
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    // ListView.builder用于动态创建任务列表的每一项
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            // 当复选框的勾选状态发生改变时，根据任务当前的完成状态显示相应的SnackBar
            onChanged: (bool? value) {
              if (value != null) {
                tasksProvider.toggleTaskCompletion(task.id, value);
                if (value) {
                  _showArchivedSnackBar(context, task, tasksProvider);
                } else {
                  _showUnarchivedSnackBar(context, task, tasksProvider);
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
