// 定义一个 Task 类，表示任务的基本属性
class Task {
  final String id; // 任务ID
  final String title; // 任务标题
  final String description; // 任务描述
  final DateTime dueDate; // 任务截止日期
  final int quadrant; // 任务所属象限（1-4）
  final bool isCompleted; // 任务的完成状态
  final DateTime? completedAt; // 任务完成的时间
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
    this.completedAt,
  });

  // 将任务对象转换为 JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'quadrant': quadrant,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority.index,
        'isCompleted': isCompleted,
        'completedAt': completedAt?.toIso8601String(),
      };

  // 从 JSON 创建任务
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      quadrant: json['quadrant'],
      dueDate: DateTime.parse(json['dueDate']),
      priority: TaskPriority.values[json['priority']],
      isCompleted: json['isCompleted'],
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }
}

enum TaskPriority { low, medium, high }

// 扩展方法
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
