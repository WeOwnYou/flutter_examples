part of 'to_do_list_bloc.dart';

abstract class ToDoListEvent extends Equatable {
  const ToDoListEvent();
  @override
  List<Object?> get props => [];
}

class ChangeDate extends ToDoListEvent {
  final DateTime newDate;
  const ChangeDate(this.newDate);
  @override
  List<Object?> get props => [newDate];
}
