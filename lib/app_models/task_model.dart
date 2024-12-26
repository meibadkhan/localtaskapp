class Task {
  int? id;
  String taskName;
  String description;
  bool isComplete;
  String dateAdded;

  Task({
    this.id,
    required this.taskName,
    required this.description,
    this.isComplete = false,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_name': taskName,
      'description': description,
      'is_complete': isComplete ? 1 : 0,
      'date_added': dateAdded,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['task_name'],
      description: map['description'],
      isComplete: map['is_complete'] == 1,
      dateAdded: map['date_added'],
    );
  }
}

