part of 'add_task_bloc.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();
  @override
  List<Object?> get props => [];
}

class TaskNameChanged extends AddTaskEvent {
  final String newTaskName;
  const TaskNameChanged(this.newTaskName);
  @override
  List<Object?> get props => [newTaskName];
}

class DateChanged extends AddTaskEvent {
  final DateTime newDate;
  const DateChanged(this.newDate);
  @override
  List<Object?> get props => [newDate];
}

class StartTimeChanged extends AddTaskEvent {
  final TimeOfDay newTimeOfStart;
  const StartTimeChanged(this.newTimeOfStart);
  @override
  List<Object?> get props => [newTimeOfStart];
}

class EndTimeChanged extends AddTaskEvent {
  final TimeOfDay newTimeOfEnd;
  const EndTimeChanged(this.newTimeOfEnd);
  @override
  List<Object?> get props => [newTimeOfEnd];
}

class DescriptionChanged extends AddTaskEvent {
  final String newDescription;
  const DescriptionChanged(this.newDescription);
  @override
  List<Object?> get props => [newDescription];
}

class CategoryChanged extends AddTaskEvent {
  final String title;
  const CategoryChanged(this.title);
  @override
  List<Object?> get props => [title];
}

class AddTask extends AddTaskEvent {}
