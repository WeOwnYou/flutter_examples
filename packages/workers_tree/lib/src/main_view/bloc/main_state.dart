part of 'main_bloc.dart';

class MainState extends Equatable {
  final Organization organization;
  final int _workersCount;
  MainState({required this.organization})
      : _workersCount = organization.departments.numberOfWorkers;
  static final MainState initial = MainState(organization: Organization.empty);
  MainState copyWith({
    Organization? organization,
  }) {
    return MainState(organization: organization ?? this.organization);
  }

  @override
  List<Object?> get props => [organization, _workersCount];
}
