part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final String userId;
  const AuthState({this.userId});

  @override
  List<Object> get props => [this.userId];
}

class AuthInitial extends AuthState {}

class AuthLoginCheck extends AuthState {
  final String userId;
  const AuthLoginCheck(this.userId) : super(userId: userId);
}

class AuthLoginLoading extends AuthState {
  const AuthLoginLoading();
}

class AuthLoginSuccess extends AuthState {
  final User user;
  const AuthLoginSuccess(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthLoginSuccess && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class AuthLoginError extends AuthState {
  final String err;
  const AuthLoginError(this.err);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthLoginError && other.err == err;
  }

  @override
  int get hashCode => err.hashCode;
}

class AuthSignUpLoading extends AuthState {
  const AuthSignUpLoading();
}

class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess();
}

class AuthSignUpError extends AuthState {
  final String err;
  const AuthSignUpError(this.err);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSignUpError && other.err == err;
  }

  @override
  int get hashCode => err.hashCode;
}

class AuthLogOut extends AuthState {
  const AuthLogOut();
}
