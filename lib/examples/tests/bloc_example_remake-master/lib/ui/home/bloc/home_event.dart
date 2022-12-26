part of 'home_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
  @override
  List<Object?> get props => [];
}

class ChangeSelectedDot extends HomePageEvent {
  final int newSelectedDot;
  const ChangeSelectedDot(this.newSelectedDot);
  @override
  List<Object?> get props => [newSelectedDot];
}

class ChangeCategory extends HomePageEvent {
  final Categories categoryName;
  const ChangeCategory(this.categoryName);
  @override
  List<Object?> get props => [categoryName];
}
