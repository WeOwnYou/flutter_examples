part of 'add_task_bloc.dart';

const categories = [
  'Design',
  'Meeting',
  'Coding',
  'BDE',
  'Testing',
  'Quick Call'
];

class AddTaskState {
  final String taskName;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String description;
  final String selectedCategory;

  const AddTaskState._({
    required this.taskName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.selectedCategory,
  });

  String get dateString {
    final month = date.getMonthName();
    final year = date.year.toString();
    final day = date.day.toString();
    return '$month $day, $year';
  }

  String get startTimeString => startTime.getTime();

  String get endTimeString => endTime.getTime();

  AddTaskState.initial(DateTime dateTime)
      : this._(
          taskName: '',
          date: dateTime,
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.now(),
          description: '',
          selectedCategory: 'Design',
        );

  AddTaskState copyWith({
    String? taskName,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? description,
    String? selectedCategory,
  }) {
    return AddTaskState._(
      taskName: taskName ?? this.taskName,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
