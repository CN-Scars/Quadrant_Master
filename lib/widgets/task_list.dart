import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/edit_task_screen.dart'; // 新增导入
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({required this.tasks});

  // 显示任务已归档的SnackBar
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
        duration: Duration(seconds: 3), // 设置SnackBar的持续时长为3秒
      ),
    );
  }

  // 显示任务已恢复为未完成状态的SnackBar
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
        duration: Duration(seconds: 3), // 设置SnackBar的持续时长为3秒
      ),
    );
  }

  // 显示删除任务确认对话框
  Future<void> _showDeleteConfirmationDialog(BuildContext context, Task task, TasksProvider tasksProvider) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 点击外部区域时不关闭对话框
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确认删除'),
          content: Text('您确定要删除任务 "${task.title}" 吗？'),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('删除'),
              onPressed: () {
                tasksProvider.deleteTask(task.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
          onTap: () { // 新增onTap事件，用于导航到任务编辑页面
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: task),
              ),
            );
          },
          onLongPress: () { // 新增长按事件，用于显示删除任务确认对话框
            _showDeleteConfirmationDialog(context, task, tasksProvider);
          },
        );
      },
    );
  }
}
