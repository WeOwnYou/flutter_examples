part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  final StorageStatus status;
  final User user;
  final List<Project>? projects;
  final List<Task>? tasks;
  final int? activeProjectId;
  final int activeTab;

  const MainScreenState._({
    this.status = StorageStatus.loading,
    required this.user,
    this.projects,
    this.tasks,
    this.activeProjectId,
    this.activeTab = 0,
  });

  MainScreenState.loading() : this._(user: User(name: 'default', uuid: '-'));
  const MainScreenState.empty(User user)
      : this._(user: user, status: StorageStatus.empty);
  const MainScreenState.data({
    required User user,
    required List<Project> projects,
    required List<Task> tasks,
    required int activeTab,
    required int? activeProjectId,
  }) : this._(
          user: user,
          status: StorageStatus.hasData,
          projects: projects,
          tasks: tasks,
          activeTab: activeTab,
          activeProjectId: activeProjectId,
        );

  MainScreenState copyWith({
    StorageStatus? status,
    User? user,
    List<Project>? projects,
    List<Task>? tasks,
    int? categoryId,
    int? activeProjectId,
    int? selectedDotIndex,
    int? activeTab,
  }) {
    return MainScreenState._(
      status: status ?? this.status,
      user: user ?? this.user,
      projects: projects ?? this.projects,
      tasks: tasks ?? this.tasks,
      activeProjectId: activeProjectId ?? this.activeProjectId,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        projects,
        tasks,
        activeProjectId,
      ];
}
