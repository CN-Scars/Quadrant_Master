// lib/providers/tasks_provider.dart

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

  // List<Task> getTasksByQuadrant(int quadrant) {
  //   // 筛选出指定象限的任务
  //   List<Task> filteredTasks = _tasks.where((task) => task.quadrant == quadrant).toList();
  //
  //   // 根据任务优先级对任务进行排序
  //   filteredTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
  //
  //   return filteredTasks;
  // }
  List<Task> getTasksByQuadrant(int quadrant) {
    List<Task> filteredTasks = _tasks.where((task) => task.quadrant == quadrant).toList();
    filteredTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return filteredTasks;
  }

  List<Task> getCompletedTasks() {
    return _tasks.where((task) => task.isCompleted).toList();
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
        priority: _tasks[taskIndex].priority,
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

  // 更新任务
  void updateTask(Task updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      // 通知侦听器数据已更改
      notifyListeners();
    }
  }

  // 在指定索引处插入任务，以便在撤销操作时，可以将任务插回到原来的位置
  void insertTaskAtIndex(Task task, int index) {
    _tasks.insert(index, task);
    notifyListeners();
  }

  // 获取未归档的任务
  List<Task> getUnarchivedTasksByQuadrant(int quadrant) {
    List<Task> filteredTasks = _tasks.where((task) => task.quadrant == quadrant && !task.isCompleted).toList();
    filteredTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return filteredTasks;
  }
}
