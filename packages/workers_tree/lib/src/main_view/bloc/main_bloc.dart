import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers_tree/src/main_view/entity/department.dart';

import '../../mock_data.dart';

part 'main_state.dart';
part 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial) {
    on<MainInitializeEvent>(_initialize);
    on<UpdateTreeEvent>(_updateTree);
    on<MoveDepartmentEvent>(_moveDepartment);
    on<AddDepartmentEvent>(_addDepartment);
    on<RemoveDepartmentEvent>(_removeDepartment);
    on<AddWorkerEvent>(_addWorker);
    on<RemoveWorkerEvent>(_removeWorker);
  }

  Future<void> _initialize(
    MainInitializeEvent event,
    Emitter<MainState> emit,
  ) async {
    final mappedOrganization = await organizationData();
    final organization = Organization.fromMap(mappedOrganization);
    return emit(state.copyWith(organization: organization));
  }

  void _updateTree(
    UpdateTreeEvent event,
    Emitter<MainState> emit,
  ) {
    final sortedDepartments = List.of(state.organization.departments)
      ..sort(
        (department1, department2) => department1.id.compareTo(department2.id),
      );
    for (var i = 0; i < sortedDepartments.length; i++) {
      final sortedWorkers = List.of(sortedDepartments[i].workers)
        ..sort((worker1, worker2) => worker1.id.compareTo(worker2.id));
      sortedDepartments[i] =
          sortedDepartments[i].copyWith(workers: sortedWorkers);
    }
    return _updateState(sortedDepartments, emit);
  }

  void _moveDepartment(
    MoveDepartmentEvent event,
    Emitter<MainState> emit,
  ) {
    final indexToInsert = state.organization.departments
        .indexWhere((department) => department.id == event.idToInsert);
    final updatedDepartments = List.of(state.organization.departments)
      ..remove(event.data)
      ..insert(indexToInsert, event.data);
    return _updateState(updatedDepartments, emit);
  }

  void _addDepartment(
    AddDepartmentEvent event,
    Emitter<MainState> emit,
  ) {
    var lastId = -1;
    for (final department in state.organization.departments) {
      if (department.id > lastId) {
        lastId = department.id;
      }
    }
    final newDepartment =
        Department(id: lastId + 1, workers: const [], name: event.name);
    final updatedDepartments = List.of(state.organization.departments)
      ..add(newDepartment);
    return _updateState(updatedDepartments, emit);
  }

  void _removeDepartment(
    RemoveDepartmentEvent event,
    Emitter<MainState> emit,
  ) {
    final updatedDepartments = List.of(state.organization.departments)
      ..removeWhere((department) => department.id == event.departmentId);
    return _updateState(updatedDepartments, emit);
  }

  void _addWorker(
    AddWorkerEvent event,
    Emitter<MainState> emit,
  ) {
    final updatedDepartments = List.of(state.organization.departments);
    final departmentIndex = updatedDepartments
        .indexWhere((department) => department.id == event.departmentId);
    final updatedWorkers = List.of(updatedDepartments[departmentIndex].workers);
    final newWorker = Worker(
      id: state.organization.departments.generateNewWorkerId,
      name: event.name,
    );
    updatedWorkers.add(newWorker);
    updatedDepartments[departmentIndex] =
        updatedDepartments[departmentIndex].copyWith(workers: updatedWorkers);
    _updateState(updatedDepartments, emit);
  }

  void _removeWorker(
    RemoveWorkerEvent event,
    Emitter<MainState> emit,
  ) {
    final updatedDepartments =
        List<Department>.from(state.organization.departments);
    final departmentIndex = updatedDepartments
        .indexWhere((department) => department.id == event.departmentId);
    final updatedWorkers = updatedDepartments[departmentIndex].workers
      ..removeWhere((worker) => worker.id == event.workerId);
    updatedDepartments[departmentIndex] =
        updatedDepartments[departmentIndex].copyWith(workers: updatedWorkers);
    _updateState(List.of(updatedDepartments), emit);
  }

  void _updateState(
    List<Department> updatedDepartments,
    Emitter<MainState> emit,
  ) {
    final updatedOrganization =
        state.organization.copyWith(departments: updatedDepartments);
    return emit(state.copyWith(organization: updatedOrganization));
  }
}
