import 'package:equatable/equatable.dart';

part 'organization.dart';
part 'worker.dart';

class Department extends Equatable {
  final int id;
  final String name;
  final List<Worker> workers;
  const Department({
    required this.id,
    required this.workers,
    required this.name,
  });
  factory Department.fromMap(Map<String, dynamic> map) => Department(
        id: map['department_id'] as int,
        workers: (map['department_workers'] as List<Map<String, dynamic>>)
            .map(Worker.fromMap)
            .toList(),
        name: map['department_name'] as String,
      );
  Department copyWith({String? name, List<Worker>? workers}) => Department(
        id: id,
        workers: workers ?? this.workers,
        name: name ?? this.name,
      );
  @override
  List<Object?> get props => [name, id, workers];
}



extension GetAllWorkers on List<Department>{
  int get generateNewWorkerId{
    var id = -1;
    forEach((department) {
      for (final worker in department.workers) {
        if(worker.id > id){
          id = worker.id;
        }
      }
    });
    return id + 1;
  }

  int get numberOfWorkers{
    var len = 0;
    forEach((element) {
      len += element.workers.length;
    });
    return len;
  }
}
