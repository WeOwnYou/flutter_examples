import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedita_learning2/ui/widgets/widgets.dart';

part 'to_do_list_event.dart';
part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  final scrollingDatesController = ScrollController();
  ToDoListBloc() : super(ToDoListState.initial()) {
    on<ChangeDate>(_onChangeDate);
  }

  void _onChangeDate(
    ChangeDate event,
    Emitter<ToDoListState> emit,
  ) {
    return emit(state.copyWith(date: event.newDate));
  }

  void animateDatesToCurrent(BuildContext context) {
    final index = state.date.day - 2;
    scrollingDatesController.animateTo(
      (index <= 0 ? 0 : index) * MediaQuery.of(context).size.width * 85 / 619,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }
}
