part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;
  final String pin;
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.pin = '',
    User? user,
  }) : user = user ?? User.defaultUser;

  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  const AuthenticationState.registering()
      : this._(status: AuthenticationStatus.registering);
  const AuthenticationState.failure()
      : this._(status: AuthenticationStatus.failure);

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    String? pin,
  }) {
    return AuthenticationState._(
      status: status ?? this.status,
      user: user ?? this.user,
      pin: pin ?? this.pin,
    );
  }

  @override
  List<Object?> get props => [status, user, pin];
}
