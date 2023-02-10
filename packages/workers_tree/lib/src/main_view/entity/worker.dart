part of 'department.dart';

class Worker extends Equatable{
  final int id;
  final String name;
  const Worker({
    required this.id,
    required this.name,
  });
  factory Worker.fromMap(Map<String, dynamic> map) => Worker(
        id: map['worker_id'] as int,
        name: map['worker_name'] as String,
      );
  @override
  List<Object?> get props => [id, name];
}
