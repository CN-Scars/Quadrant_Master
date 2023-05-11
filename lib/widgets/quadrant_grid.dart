import 'package:flutter/material.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class QuadrantGrid extends StatefulWidget {
  final Function(int) onTap;

  QuadrantGrid({required this.onTap});

  @override
  _QuadrantGridState createState() => _QuadrantGridState();
}

class _QuadrantGridState extends State<QuadrantGrid>
    with SingleTickerProviderStateMixin {
  int? _selectedQuadrant;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTaskList(BuildContext context, int quadrant, List<Task> tasks,
      TasksProvider tasksProvider) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: tasks[index].isCompleted,
            onChanged: (newValue) {
              tasksProvider.toggleTaskCompletion(tasks[index].id, newValue!);
              // 移除当前的SnackBar，实现替换效果
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              scaffoldMessenger.hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('任务已归档'),
                  action: SnackBarAction(
                    label: '撤销',
                    onPressed: () {
                      tasksProvider.toggleTaskCompletion(
                          tasks[index].id, !newValue);
                      },
                  ),
                  // duration: Duration(seconds: 3), // 设置SnackBar的持续时长为3秒
                ),
              );
              // 由于未知原因，SnackBar的duration属性不会生效，只能使用延时执行的方式在SnackBar持续3s后手动移除
              Future.delayed(Duration(seconds: 3), () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              });
            },
          ),
          title: Text(tasks[index].title),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              ((MediaQuery.of(context).size.height - kToolbarHeight) *
                  0.76), // 可通过调整系数，实现拉伸象限格子
        ),
        itemBuilder: (context, index) {
          final quadrantTasks =
              tasksProvider.getUnarchivedTasksByQuadrant(index + 1);
          return GestureDetector(
            onTap: () => widget.onTap(index + 1),
            child: Hero(
              tag: 'quadrant-${index + 1}',
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.blue.shade200,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: index == 0
                                      ? '重要'
                                      : index == 1
                                          ? '重要'
                                          : index == 2
                                              ? '紧急'
                                              : '不重要',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: '\n',
                                ),
                                TextSpan(
                                  text: index == 0
                                      ? '且紧急'
                                      : index == 1
                                          ? '不紧急'
                                          : index == 2
                                              ? '不重要'
                                              : '且紧急',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      quadrantTasks.isNotEmpty
                          ? Expanded(
                              flex: 2,
                              child: _buildTaskList(context, index + 1,
                                  quadrantTasks, tasksProvider),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
