part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class MainInitializeEvent extends MainEvent {
  const MainInitializeEvent();
}

class UpdateTreeEvent extends MainEvent{
  const UpdateTreeEvent();
}

class MoveDepartmentEvent extends MainEvent{
  final int idToInsert;
  final Department data;
  const MoveDepartmentEvent({required this.idToInsert, required this.data,});
}

class AddDepartmentEvent extends MainEvent {
  final String name;
  const AddDepartmentEvent({required this.name});
}

class RemoveDepartmentEvent extends MainEvent {
  final int departmentId;
  const RemoveDepartmentEvent({required this.departmentId});
}

class AddWorkerEvent extends MainEvent{
  final int departmentId;
  final String name;
  const AddWorkerEvent({required this.name, required this.departmentId});
}

class RemoveWorkerEvent extends MainEvent {
  final int workerId;
  final int departmentId;
  const RemoveWorkerEvent({required this.workerId, required this.departmentId});
}
