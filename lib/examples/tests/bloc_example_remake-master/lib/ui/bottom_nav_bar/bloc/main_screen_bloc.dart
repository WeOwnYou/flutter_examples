import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:user_repository/user_repository.dart' hide User;

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final UserRepository _userRepository;
  final HiveRepository _hiveRepository;
  String _username = '';
  late final StreamSubscription<StorageStatus> _homePageStatusSubscription;

  String get username => _username;
  HiveRepository get hiveRepository => _hiveRepository;

  MainBloc({
    required UserRepository userRepository,
    required HiveRepository hiveRepository,
  })  : _hiveRepository = hiveRepository,
        _userRepository = userRepository,
        super(MainScreenState.loading()) {
    _homePageStatusSubscription = _hiveRepository.status.listen((status) {
      add(StorageStatusChanged(status));
    });
    on<StorageStatusChanged>(_onStorageStatusChanged);
    on<ChangeUsername>(_onChangeUsername);
    on<AddProject>(_onAddProject);
    on<ChangeProject>(_onChangeProject);
    on<RemoveProject>(_onRemoveProject);
    on<RemoveTask>(_onRemoveTask);
  }

  Future<void> _onStorageStatusChanged(
    StorageStatusChanged event,
    Emitter<MainScreenState> emit,
  ) async {
    final user = await _userRepository.getUser();
    final mainScreenUser = User(
      name: user.username,
      uuid: user.id,
    );
    _username = mainScreenUser.name;
    switch (event.status) {
      case StorageStatus.empty:
        return emit(MainScreenState.empty(mainScreenUser));
      case StorageStatus.hasData:
        final projects = _hiveRepository.projects;
        final tasks = _hiveRepository.tasks;
        return emit(
          MainScreenState.data(
            user: mainScreenUser,
            projects: projects,
            tasks: tasks,
            activeTab: state.activeTab,
            activeProjectId:
                state.activeProjectId ?? (tasks.isEmpty ? null : 0),
          ),
        );
      case StorageStatus.loading:
        return emit(MainScreenState.loading());
    }
  }

  void _onChangeUsername(
    ChangeUsername event,
    Emitter<MainScreenState> emit,
  ) {
    final newUser = User(name: event.newUsername, uuid: state.user.uuid);
    _userRepository.setUsername(event.newUsername);
    return emit(state.copyWith(user: newUser));
  }

  Future<void> _onAddProject(
    AddProject event,
    Emitter<MainScreenState> emit,
  ) async {
    await _hiveRepository.addProject(event.project);
    return emit(
      state.copyWith(
        projects: _hiveRepository.projects,
        activeProjectId: _hiveRepository.activeProjectKey,
      ),
    );
  }

  Future<void> _onChangeProject(
    ChangeProject event,
    Emitter<MainScreenState> emit,
  ) async {
    await _hiveRepository.changeProject(event.newProjectId);
    return emit(
      state.copyWith(
        tasks: _hiveRepository.tasks,
        projects: _hiveRepository.projects,
        activeProjectId: _hiveRepository.activeProjectKey,
      ),
    );
  }

  Future<void> _onRemoveProject(
    RemoveProject event,
    Emitter<MainScreenState> emit,
  ) async {
    await _hiveRepository.removeProject();
    return emit(
      state.copyWith(
        projects: _hiveRepository.projects,
        activeProjectId: _hiveRepository.activeProjectKey,
      ),
    );
  }

  Future<void> _onRemoveTask(
    RemoveTask event,
    Emitter<MainScreenState> emit,
  ) async {
    await _hiveRepository.removeTask(event.index);
    return emit(state.copyWith(tasks: _hiveRepository.tasks));
  }

  void dispose() {
    _homePageStatusSubscription.cancel();
    _hiveRepository.dispose();
  }
}
