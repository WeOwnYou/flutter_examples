// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 4;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[0] as String,
      taskStartTime: fields[1] as TimeOfDay,
      taskEndTime: fields[2] as TimeOfDay,
      description: fields[3] as String?,
      isDone: fields[4] as bool?,
      type: fields[5] as TaskTypes,
      dateTime: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.taskStartTime)
      ..writeByte(2)
      ..write(obj.taskEndTime)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isDone)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskTypesAdapter extends TypeAdapter<TaskTypes> {
  @override
  final int typeId = 3;

  @override
  TaskTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskTypes.design;
      case 1:
        return TaskTypes.meeting;
      case 2:
        return TaskTypes.coding;
      case 3:
        return TaskTypes.bde;
      case 4:
        return TaskTypes.testing;
      case 5:
        return TaskTypes.quickCall;
      default:
        return TaskTypes.design;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypes obj) {
    switch (obj) {
      case TaskTypes.design:
        writer.writeByte(0);
        break;
      case TaskTypes.meeting:
        writer.writeByte(1);
        break;
      case TaskTypes.coding:
        writer.writeByte(2);
        break;
      case TaskTypes.bde:
        writer.writeByte(3);
        break;
      case TaskTypes.testing:
        writer.writeByte(4);
        break;
      case TaskTypes.quickCall:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
