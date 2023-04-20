// 定义一个 Task 类，表示任务的基本属性
class Task {
  final String id; // 任务ID
  final String title; // 任务标题
  final String description; // 任务描述
  final DateTime dueDate; // 任务截止日期
  final int quadrant; // 任务所属象限（1-4）
  final bool isCompleted; // 任务的完成状态

  // 构造函数，用于创建 Task 对象
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.quadrant,
    required this.dueDate,
    this.isCompleted = false,
  });
}

// class Task {
//   final String id;
//   final String title;
//   final String description;
//   final int quadrant;
//   final DateTime dueDate;
//   final bool isCompleted;
//
//   Task({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.quadrant,
//     required this.dueDate,
//     this.isCompleted = false,
//   });
// }

