import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: 3)
enum TaskTypes {
  @HiveField(0)
  design,
  @HiveField(1)
  meeting,
  @HiveField(2)
  coding,
  @HiveField(3)
  bde,
  @HiveField(4)
  testing,
  @HiveField(5)
  quickCall,
}

@HiveType(typeId: 4)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  TimeOfDay taskStartTime;
  @HiveField(2)
  TimeOfDay taskEndTime;
  @HiveField(3)
  String? description;
  @HiveField(4)
  bool? isDone = false;
  @HiveField(5)
  TaskTypes type;
  @HiveField(6)
  DateTime dateTime;

  Task({
    required this.title,
    required this.taskStartTime,
    required this.taskEndTime,
    this.description,
    this.isDone,
    required this.type,
    required this.dateTime,
  });

  int durationMinutes() {
    return (taskEndTime.hour - taskStartTime.hour) * 60 +
        (taskEndTime.minute - taskStartTime.minute);
  }
}
