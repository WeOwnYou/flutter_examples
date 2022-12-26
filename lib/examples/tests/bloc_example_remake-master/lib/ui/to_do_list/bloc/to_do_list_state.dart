part of 'to_do_list_bloc.dart';

class ToDoListState extends Equatable {
  final DateTime date;
  String get month => date.getMonthName();
  String get year => date.year.toString();
  const ToDoListState._({required this.date});
  ToDoListState.initial()
      : this._(date: DateTime.now());

  ToDoListState copyWith({DateTime? date}) {
    return ToDoListState._(date: date ?? this.date);
  }



  @override
  List<Object?> get props => [date];
}
