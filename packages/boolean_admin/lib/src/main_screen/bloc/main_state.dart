part of 'main_bloc.dart';

class MainState extends Equatable {
  final List<SwitcherBlock> switcherBlocks;
  const MainState({required this.switcherBlocks});
  static const MainState initial = MainState(switcherBlocks: []);

  MainState copyWith({List<SwitcherBlock>? switcherBlocks}) {
    return MainState(switcherBlocks: switcherBlocks ?? this.switcherBlocks);
  }

  @override
  List<Object?> get props => [switcherBlocks];
}
