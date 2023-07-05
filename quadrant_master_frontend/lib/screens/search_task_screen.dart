import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/widgets/task_list.dart';

class SearchTaskScreen extends StatelessWidget {
  final String query;

  SearchTaskScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final tasks = tasksProvider.searchTasks(query);

    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                '没有找到相关任务',
                style: TextStyle(fontSize: 18),
              ),
            )
          : TaskList(tasks: tasks),
    );
  }
}
