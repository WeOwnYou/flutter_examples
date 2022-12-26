import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomePageEvent, HomePageState> {
  final ScrollController _pageScrollController = ScrollController();
  double _projectPageSize = 0;
  Timer? debouncer;

  HomeBloc() : super(const HomePageState.initial()) {
    on<ChangeCategory>(_onChangeCategory);
    on<ChangeSelectedDot>(_onChangeSelectedDot);
  }

  ScrollController getPageScrollController(double projectPageSize) {
    _projectPageSize = projectPageSize;
    _pageScrollController.addListener(_pageControllerListener);
    return _pageScrollController;
  }

  void _pageControllerListener() {
    final scrolled = _pageScrollController.position.pixels;
    var newIndex = scrolled ~/ _projectPageSize;
    if ((scrolled / _projectPageSize) * 10 - newIndex * 10 > 5 ||
        scrolled == _pageScrollController.position.maxScrollExtent) {
      newIndex++;
    }
    if (state.selectedDotIndex != newIndex) {
      add(ChangeSelectedDot(newIndex));
    }
  }

  void _onChangeCategory(
    ChangeCategory event,
    Emitter<HomePageState> emit,
  ) {
    final oldState = state;
    final newState = state.copyWith(category: event.categoryName);
    return emit(newState);
  }

  void _onChangeSelectedDot(
    ChangeSelectedDot event,
    Emitter<HomePageState> emit,
  ) {
    return emit(state.copyWith(selectedDotIndex: event.newSelectedDot));
  }
}
