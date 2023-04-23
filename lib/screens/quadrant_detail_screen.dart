import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/edit_task_screen.dart';

class QuadrantDetailScreen extends StatelessWidget {
  final int quadrant;

  QuadrantDetailScreen({required this.quadrant});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final List<Task> tasks = tasksProvider.getTasksByQuadrant(quadrant);

    return Scaffold(
      appBar: AppBar(
        title: Text('象限 $quadrant'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) {
                if (value != null && value) {
                  tasksProvider.toggleTaskCompletion(task.id, value);

                  int originalIndex = tasks.indexOf(task); // 记住任务的原始索引
                  tasksProvider.deleteTask(task.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('任务已完成'),
                      action: SnackBarAction(
                        label: '撤销',
                        // 回调
                        onPressed: () {
                          final undoneTask = Task(
                            id: task.id,
                            title: task.title,
                            description: task.description,
                            quadrant: task.quadrant,
                            dueDate: task.dueDate,
                            isCompleted: false, // 将任务标记为未完成
                            priority: task.priority,
                          );
                          tasksProvider.insertTaskAtIndex(undoneTask, originalIndex); // 使用原始索引插入任务
                        },
                      ),
                    ),
                  );
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: task),
                ),
              );
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('删除任务'),
                  content: Text('您确定要删除这个任务吗？'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('取消'),
                    ),
                    TextButton(
                      onPressed: () {
                        tasksProvider.deleteTask(task.id);
                        Navigator.of(ctx).pop();
                      },
                      child: Text('删除'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
