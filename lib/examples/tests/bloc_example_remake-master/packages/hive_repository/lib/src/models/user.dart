import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  final String uuid;
  User({required this.name, required this.uuid});
}
