part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class UpdateSwitcherBlocksEvent extends MainEvent {
  final List<SwitcherBlock> switcherBlocks;
  const UpdateSwitcherBlocksEvent(this.switcherBlocks);
}

class UpdateSingleSwitcherEvent extends MainEvent {
  final String blockId;
  final SwitcherType switcherType;
  final bool value;
  const UpdateSingleSwitcherEvent({
    required this.blockId,
    required this.switcherType,
    required this.value,
  });
}

class UpdateConnectionStatusEvent extends MainEvent {
  final bool hasInternet;
  const UpdateConnectionStatusEvent({required this.hasInternet});
}
