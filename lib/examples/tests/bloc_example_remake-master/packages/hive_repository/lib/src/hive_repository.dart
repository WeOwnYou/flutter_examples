import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:hive_repository/src/hive_provider.dart';
import 'package:hive_repository/src/models/models.dart';

enum StorageStatus { empty, hasData, loading }

class HiveRepository {
  final _controller = StreamController<StorageStatus>();
  ValueListenable<Box<Project>>? _projectListenable;
  ValueListenable<Box<Task>>? _taskListenable;
  late final Future<Box<Project>> _projectBox;
  late Future<Box<Task>> _taskBox;
  List<Project> _projects = [];
  List<Task> _tasks = [];
  int? _activeProjectKey;

  Stream<StorageStatus> get status async* {
    yield StorageStatus.loading;
    await _loadData();
    if (_projects.isEmpty) {
      yield StorageStatus.empty;
    } else {
      yield StorageStatus.hasData;
    }
    yield* _controller.stream;
  }

  int? get activeProjectKey => _activeProjectKey;
  List<Task> get tasks => _tasks;
  List<Project> get projects => _projects;

  Future<void> _loadData() async {
    await _setProjectBox();
    if ((await _projectBox).isEmpty) return;
    await _readProjectsFromHive();
    await _setTaskBox();
  }

  Future<void> _setProjectBox() async {
    _projectBox = HiveProvider.instance.openProjectBox();
    _projectListenable = (await _projectBox).listenable();
    _projectListenable?.addListener(_readProjectsFromHive);
  }

  Future<void> _readProjectsFromHive() async {
    _projects = (await _projectBox).values.toList();
    if ((await _projectBox).length != 0) {
      _activeProjectKey = 0;
    }
  }

  Future<void> _readTasksFromHive() async {
    _tasks = (await _taskBox).values.toList();
    _controller.add(StorageStatus.hasData);
  }

  Future<void> _setTaskBox() async {
    var taskBoxKey = 0;
    final keys = (await _projectBox).keys.toList();
    if (_activeProjectKey == null ||
        keys.isEmpty ||
        keys[_activeProjectKey!] == null) {
      return;
    } else {
      taskBoxKey = keys[_activeProjectKey!] as int;
    }
    _taskBox = HiveProvider.instance.openTaskBox(taskBoxKey);
    _taskListenable = (await _taskBox).listenable();
    _taskListenable?.addListener(_readTasksFromHive);
    await _readTasksFromHive();
  }

  Future<void> addProject(Project newProject) async {
    if (newProject.projectTitle == '') return;
    for (final project in _projects) {
      if (project.projectTitle == newProject.projectTitle) return;
    }
    _activeProjectKey = newProject.id = _projects.length;
    await (await _projectBox).add(newProject);
    await (await _projectBox).compact();
    await _readProjectsFromHive();
    await _setTaskBox();
  }

  Future<void> addTask(Task newTask) async {
    if (_activeProjectKey == null) return;
    await (await _taskBox).add(newTask);
    await (await _taskBox).compact();
    await _readTasksFromHive();
  }

  Future<void> removeProject() async {
    final keys = (await _projectBox).keys.toList();
    if (_activeProjectKey == null || keys[_activeProjectKey!] == null) return;
    await (await _taskBox).deleteFromDisk();
    await (await _projectBox).delete(keys[_activeProjectKey!]);
    if ((await _projectBox).keys.isEmpty || _activeProjectKey! < 1) {
      _activeProjectKey = 0;
    } else {
      _activeProjectKey = _activeProjectKey! - 1;
    }
    await _resetProjectKeys();
    await _setTaskBox();
  }

  Future<void> removeTask(int index) async {
    await (await _taskBox).deleteAt(index);
    await (await _taskBox).compact();
  }


  Future<void> changeProject(int newProjectKey) async {
    if (newProjectKey == _activeProjectKey) return;
    _activeProjectKey = newProjectKey;
    await _setTaskBox();
  }

  Future<void> _resetProjectKeys() async {
    final projects = (await _projectBox).values.toList();
    for (var i = 0; i < projects.length; i++) {
      projects[i].id = i;
      await projects[i].save();
    }
  }

  void dispose() => _controller.close();
}
