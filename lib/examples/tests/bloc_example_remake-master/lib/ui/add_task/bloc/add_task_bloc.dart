import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:vedita_learning2/ui/bottom_nav_bar/bloc/main_screen_bloc.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final HiveRepository hiveRepository;
  final void Function(MainScreenEvent event) addEventFromMainBloc;
  AddTaskBloc({
    required this.hiveRepository,
    required this.addEventFromMainBloc,
    required DateTime date,
  }) : super(AddTaskState.initial(date)) {
    on<TaskNameChanged>(_onTaskNameChanged);
    on<DateChanged>(_onDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<EndTimeChanged>(_onEndTimeChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<AddTask>(_onAddTask);
  }

  Future<void> changeDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: state.date,
      firstDate: DateTime(2020, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != state.date) {
      add(DateChanged(picked));
    }
  }

  Future<void> changeTime({
    required BuildContext context,
    required bool isStartTime,
  }) async {
    final selectedTime = isStartTime ? state.startTime : state.endTime;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      if (isStartTime) {
        if (state.startTime == pickedTime) return;
        add(StartTimeChanged(pickedTime));
        return;
      }
      if (state.endTime == pickedTime) return;
      add(EndTimeChanged(pickedTime));
    }
  }

  void _onTaskNameChanged(
    TaskNameChanged event,
    Emitter<AddTaskState> emit,
  ) {
    return emit(state.copyWith(taskName: event.newTaskName));
  }

  void _onDateChanged(
    DateChanged event,
    Emitter<AddTaskState> emit,
  ) {
    return emit(state.copyWith(date: event.newDate));
  }

  void _onStartTimeChanged(
    StartTimeChanged event,
    Emitter<AddTaskState> emit,
  ) {
    return emit(state.copyWith(startTime: event.newTimeOfStart));
  }

  void _onEndTimeChanged(
    EndTimeChanged event,
    Emitter<AddTaskState> emit,
  ) {
    return emit(state.copyWith(endTime: event.newTimeOfEnd));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<AddTaskState> emit,
  ) {
    return emit(state.copyWith(description: event.newDescription));
  }

  void _onCategoryChanged(
    CategoryChanged event,
    Emitter<AddTaskState> emit,
  ) {
    return emit(state.copyWith(selectedCategory: event.title));
  }

  Future<void> _onAddTask(
    AddTask event,
    Emitter<AddTaskState> emit,
  ) async {
    final type = TaskTypes.values[categories.indexOf(state.selectedCategory)];
    final task = Task(
      title: state.taskName,
      taskStartTime: state.startTime,
      taskEndTime: state.endTime,
      type: type,
      dateTime: state.date,
    );
    await hiveRepository.addTask(task);
    // addEventFromMainBloc(RefreshTasks());
  }
}
