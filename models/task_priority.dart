enum TaskPriority {
  low,
  medium,
  high,
}

extension TaskPriorityExtension on TaskPriority {
  String toShortString() {
    return toString().split('.').last;
  }
}
