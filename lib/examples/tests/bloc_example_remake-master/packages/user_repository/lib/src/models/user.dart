import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String username;
  static const defaultUser = User(id: '-');

  const User({required this.id, String? username})
      : username = username ?? 'default';
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  List<Object?> get props => [username];

  User copyWith({required String username}) => User(
        username: username,
        id: id,
      );

  @override
  String toString() => '{"id": "$id", "username": "$username"}';
}
