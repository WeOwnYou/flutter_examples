import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  registering,
  failure
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _secureStorage = const FlutterSecureStorage();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (await _secureStorage.read(key: 'pin') == null) {
      yield AuthenticationStatus.registering;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String pin,
  }) async {
    await Future<void>.delayed(
      const Duration(microseconds: 300),
    );
    if (await _secureStorage.read(key: 'pin') == pin) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.failure);
      Future<void>.delayed(const Duration(milliseconds: 300), () {
        _controller.add(AuthenticationStatus.unauthenticated);
      });
    }
  }

  Future<void> signUp({required String pin}) async {
    await _secureStorage.write(key: 'pin', value: pin);
    await logIn(pin: pin);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
