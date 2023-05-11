// lib/providers/tasks_provider.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quadrant_master/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks(); // 保存任务列表

    // 通知侦听器数据已更改
    notifyListeners();
  }

  List<Task> getTasksByQuadrant(int quadrant) {
    // 筛选出指定象限的任务
    List<Task> filteredTasks =
        _tasks.where((task) => task.quadrant == quadrant).toList();

    // 根据任务的完成状态和完成时间进行排序
    filteredTasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      } else if (a.isCompleted && b.isCompleted) {
        return b.completedAt!.compareTo(a.completedAt!); // 早完成的任务排在晚完成的任务后面
      } else {
        return b.priority.index.compareTo(a.priority.index);
      }
    });

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
        completedAt: isCompleted ? DateTime.now() : null,
        // 设置任务完成的时间
        priority: _tasks[taskIndex].priority,
      );
      saveTasks(); // 保存任务列表

      // 通知侦听器数据已更改
      notifyListeners();
    }
  }

  // 删除指定ID的任务
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    saveTasks(); // 保存任务列表

    // 通知侦听器数据已更改
    notifyListeners();
  }

  // 更新任务
  void updateTask(Task updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      saveTasks(); // 保存任务列表

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
    List<Task> filteredTasks = _tasks
        .where((task) => task.quadrant == quadrant && !task.isCompleted)
        .toList();
    filteredTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return filteredTasks;
  }

  List<Task> searchTasks(String query) {
    return _tasks
        .where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            task.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // 保存任务列表
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksJson);
  }

  // 加载任务列表
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      List<dynamic> tasksList = jsonDecode(tasksJson);
      _tasks.clear();
      _tasks.addAll(tasksList.map((json) => Task.fromJson(json)).toList());
    }
  }
}
