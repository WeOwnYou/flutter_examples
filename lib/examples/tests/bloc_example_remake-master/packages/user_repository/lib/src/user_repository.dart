import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepository{
  User? _user;
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  Future<User> getUser() async {
    if (_user != null) return _user!;
    final userString = await _flutterSecureStorage.read(key: 'user');
    return _user = userString != null
        ? User.fromJson(jsonDecode(userString) as Map<String, dynamic>)
        : User(id: const Uuid().v4());
  }

  void setUsername(String username) {
    if (_user == null) return;
    _user = _user!.copyWith(username: username);
    _flutterSecureStorage.write(key: 'user', value: _user!.toString());
  }
}
