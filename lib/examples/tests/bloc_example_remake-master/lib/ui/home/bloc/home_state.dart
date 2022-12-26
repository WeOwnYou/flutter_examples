part of 'home_bloc.dart';

enum Categories {myTasks, inProgress, completed}

class HomePageState extends Equatable {
  final Categories category;
  final int? selectedDotIndex;

  const HomePageState._({
    this.category = Categories.myTasks,
    this.selectedDotIndex,
  });

  const HomePageState.initial() : this._();

  HomePageState copyWith({
    Categories? category,
    int? activeProjectId,
    int? selectedDotIndex,
  }) {
    return HomePageState._(
      category: category ?? this.category,
      selectedDotIndex: selectedDotIndex ?? this.selectedDotIndex,
    );
  }

  @override
  List<Object?> get props => [category, selectedDotIndex];
}
