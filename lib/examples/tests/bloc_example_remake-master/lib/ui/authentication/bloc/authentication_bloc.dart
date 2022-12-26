import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late final StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<PinChanged>(_onPinChanged);
    on<PinSubmitted>(_onPinSubmitted);
    _authenticationStatusSubscription = _authenticationRepository.status
        .listen((status) => add(AuthenticationStatusChanged(status)));
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
      case AuthenticationStatus.authenticated:
        final user = await _userRepository.getUser();
        return emit(AuthenticationState.authenticated(user));
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.registering:
        return emit(const AuthenticationState.registering());
      case AuthenticationStatus.failure:
        return emit(const AuthenticationState.failure());
    }
  }

  void _onPinChanged(
    PinChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    if (state.status == AuthenticationStatus.unauthenticated ||
        state.status == AuthenticationStatus.registering) {
      if (state.pin.length == 4) {
        add(PinSubmitted());
      }
      if (event.digit == -1) {
        emit(state.copyWith(pin: state.pin.substring(0, state.pin.length - 1)));
      } else {
        emit(state.copyWith(pin: '${state.pin}${event.digit}'));
      }
      if (state.pin.length == 4) {
        add(PinSubmitted());
      }
    }
  }

  Future<void> _onPinSubmitted(
    PinSubmitted event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (await _userRepository.getUser() != User.defaultUser) {
      try {
        await _authenticationRepository.logIn(pin: state.pin);
      } on Exception {
        emit(const AuthenticationState.failure());
      }
      return;
    }
    await _authenticationRepository.signUp(pin: state.pin);
    _userRepository.setUsername('username');
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
