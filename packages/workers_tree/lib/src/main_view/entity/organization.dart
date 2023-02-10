part of 'department.dart';

class Organization extends Equatable {
  final int id;
  final String name;
  final List<Department> departments;
  const Organization({
    required this.id,
    required this.name,
    required this.departments,
  });
  static const empty = Organization(id: -1, name: ' ', departments: []);
  bool get isEmpty => this == empty;
  factory Organization.fromMap(Map<String, dynamic> map) => Organization(
        id: map['organization_id'] as int,
        name: map['organization_name'] as String,
        departments:
            (map['organization_departments'] as List<Map<String, dynamic>>)
                .map(Department.fromMap)
                .toList(),
      );
  Organization copyWith({String? name, List<Department>? departments}) =>
      Organization(
        id: id,
        name: name ?? this.name,
        departments: departments ?? this.departments,
      );
  @override
  List<Object?> get props => [id, name, departments];
}
