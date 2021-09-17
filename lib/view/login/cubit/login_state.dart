part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final FormBuilderState formState;

  const LoginState({
    this.email,
    this.password,
    this.formState,
  });

  @override
  List<Object> get props => [email, password, formState];

  LoginState copyWith({
    String email,
    String password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formState: formState ?? this.formState,
    );
  }
}
