import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_repository/src/models/models.dart';

class HiveProvider {
  HiveProvider._();
  static final HiveProvider instance = HiveProvider._();

  Future<Box<Project>> openProjectBox() async {
    return await _openBox(ProjectAdapter(), 'project');
  }

  Future<Box<User>> openPersonBox() async {
    return await _openBox(UserAdapter(), 'person');
  }

  Future<Box<Task>> openTaskBox(int projectTitle) async {
    return await _openBox(TaskAdapter(), 'taskBox_$projectTitle');
  }

  FutureOr<Box<T>> _openBox<T>(TypeAdapter<T> typeAdapter, String name) async {
    if (!Hive.isAdapterRegistered(typeAdapter.typeId)) {
      Hive.registerAdapter<T>(typeAdapter);
    }
    return Hive.isBoxOpen(name)
        ? Hive.box<T>(name)
        : await Hive.openBox<T>(name);
  }

  void closeBox(Box<dynamic> box) {
    box
      ..compact()
      ..close();
  }
}
