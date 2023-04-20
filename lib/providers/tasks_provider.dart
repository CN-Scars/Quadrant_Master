import 'package:flutter/foundation.dart';
import 'package:quadrant_master/models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    // 通知侦听器数据已更改
    notifyListeners();
  }

  List<Task> getTasksByQuadrant(int quadrant) {
    return _tasks.where((task) => task.quadrant == quadrant).toList();
  }

  void toggleTaskCompletion(String taskId, bool isCompleted) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: _tasks[taskIndex].id,
        title: _tasks[taskIndex].title,
        description: _tasks[taskIndex].description,
        quadrant: _tasks[taskIndex].quadrant,
        dueDate: _tasks[taskIndex].dueDate,
        isCompleted: isCompleted,
      );
      // 通知侦听器数据已更改
      notifyListeners();
    }
  }

  // 删除指定ID的任务
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    // 通知侦听器数据已更改
    notifyListeners();
  }
}

