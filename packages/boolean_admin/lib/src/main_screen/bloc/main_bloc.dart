import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:boolean_admin_repository/boolean_admin_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final BooleanAdminRepository _booleanAdminRepository;

  MainBloc({required BooleanAdminRepository booleanAdminRepository})
      : _booleanAdminRepository = booleanAdminRepository,
        super(MainState.initial) {
    on<UpdateConnectionStatusEvent>(_updateConnectionStatus);
    on<UpdateSingleSwitcherEvent>(
      _updateSingleSwitcher,
      transformer: sequential(),
    );
    on<UpdateSwitcherBlocksEvent>(_updateSwitcherBlocks);
    _booleanAdminRepository.switcherBlocksStream.listen((switcherBlocks) {
      add(
        UpdateSwitcherBlocksEvent(
          switcherBlocks
            ..sort((switcherBlock1, switcherBlock2) {
              return switcherBlock1.sortingOrderNumber
                  .compareTo(switcherBlock2.sortingOrderNumber);
            }),
        ),
      );
    });
  }

  void _updateSwitcherBlocks(
    UpdateSwitcherBlocksEvent event,
    Emitter<MainState> emit,
  ) {
    return emit(state.copyWith(switcherBlocks: event.switcherBlocks));
  }

  void _updateSingleSwitcher(
    UpdateSingleSwitcherEvent event,
    Emitter<MainState> emit,
  ) {
    //update localDb
    _booleanAdminRepository.updateSingleSwitcher(
      blockId: event.blockId,
      type: event.switcherType,
      value: event.value,
    );
    //update UI
    final switcherBlocks = List<SwitcherBlock>.from(state.switcherBlocks);
    final switcherBlockIndex =
        switcherBlocks.indexWhere((block) => block.id == event.blockId);

    switch (event.switcherType) {
      case SwitcherType.simpleSwitcher:
        switcherBlocks[switcherBlockIndex] = switcherBlocks[switcherBlockIndex]
            .copyWith(simpleSwitcherState: event.value);
        break;
      case SwitcherType.radioSwitcher:
        switcherBlocks[switcherBlockIndex] = switcherBlocks[switcherBlockIndex]
            .copyWith(radioSwitcherState: event.value);
        break;
      case SwitcherType.checkboxSwitcher:
        switcherBlocks[switcherBlockIndex] = switcherBlocks[switcherBlockIndex]
            .copyWith(checkboxSwitcherState: event.value);
        break;
    }
    return emit(state.copyWith(switcherBlocks: switcherBlocks));
  }

  Future<void> forceUpdate() async {
    //just to show, that loading is working
    final t = Timer(const Duration(milliseconds: 500), () {});
    await _booleanAdminRepository.forceUpdate();
    if (t.isActive) {
      await Future<void>.delayed(const Duration(seconds: 1));
    } else {
      t.cancel();
    }
  }

  void _updateConnectionStatus(
      UpdateConnectionStatusEvent event,
      Emitter<MainState> emit,
      ){
    _booleanAdminRepository.updateSyncStatus(event.hasInternet);
  }
}
