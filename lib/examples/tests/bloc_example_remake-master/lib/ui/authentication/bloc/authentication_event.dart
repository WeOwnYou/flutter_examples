part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class PinChanged extends AuthenticationEvent {
  final int digit;
  const PinChanged(this.digit);
  @override
  List<Object?> get props => [digit];
}

class PinSubmitted extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
