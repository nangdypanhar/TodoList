class Todolist {
  String? task;
  DateTime? date;
  int? isDone;
  int? user_id;

  Todolist(
      {required this.task,
      required this.date,
      required this.isDone,
      required this.user_id});

  Todolist.fromJSON(Map<String, Object?> json)
      : this(
          task: json['task'] as String,
          date: json['date'] as DateTime,
          isDone: json['isDone'] as int,
          user_id: json['user_id'] as int,
        );

  Map<String, Object?> toJson() {
    return {
      'task': task,
      'date': date?.toIso8601String(),
      'isDone': isDone,
      'user_id': user_id,
    };
  }

  // Todolist copyWith({
  //   DateTime? date,
  //   String? task,
  //   int? isDone,
  // }) {
  //   return Todolist(
  //     date: date ?? this.date,
  //     task: task ?? this.task,
  //     isDone: isDone ?? this.isDone,
  //   );
  // }
}
