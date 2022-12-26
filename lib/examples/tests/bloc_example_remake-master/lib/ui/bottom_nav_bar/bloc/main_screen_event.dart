part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();
  @override
  List<Object?> get props => [];
}

class StorageStatusChanged extends MainScreenEvent {
  final StorageStatus status;
  const StorageStatusChanged(this.status);
  @override
  List<Object?> get props => [status];
}

class ChangeUsername extends MainScreenEvent {
  final String newUsername;
  const ChangeUsername(this.newUsername);
  @override
  List<Object?> get props => [newUsername];
}

class AddProject extends MainScreenEvent {
  final Project project;
  const AddProject(this.project);
  @override
  List<Object?> get props => [project];
}

class ChangeProject extends MainScreenEvent {
  final int newProjectId;
  const ChangeProject(this.newProjectId);
  @override
  List<Object?> get props => [newProjectId];
}

class RemoveProject extends MainScreenEvent {}

class RemoveTask extends MainScreenEvent {
  final int index;
  const RemoveTask(this.index);
  @override
  List<Object?> get props => [];
}

class RefreshTasks extends MainScreenEvent {}

class RefreshSearchScreen extends MainScreenEvent {}

