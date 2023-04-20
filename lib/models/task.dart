// 定义一个 Task 类，表示任务的基本属性
class Task {
  final String id; // 任务ID
  final String title; // 任务标题
  final String description; // 任务描述
  final DateTime dueDate; // 任务截止日期
  final int quadrant; // 任务所属象限（1-4）
  final bool isCompleted; // 任务的完成状态
  final TaskPriority priority; // 任务优先级

  // 构造函数，用于创建 Task 对象
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.quadrant,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}

enum TaskPriority { low, medium, high }

// 在 models/task.dart 文件中添加以下扩展方法
extension TaskPriorityExtension on TaskPriority {
  String toShortString() {
    switch (this) {
      case TaskPriority.low:
        return '低';
      case TaskPriority.medium:
        return '中';
      case TaskPriority.high:
        return '高';
    }
  }
}
