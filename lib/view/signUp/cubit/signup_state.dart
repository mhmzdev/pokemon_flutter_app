part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String password;
  final FormBuilderState formState;

  SignUpState({
    this.email,
    this.name,
    this.password,
    this.formState,
  });

  @override
  List<Object> get props => [email, password, name];

  SignUpState copyWith({
    String email,
    String password,
    FormBuilderState state,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      formState: state ?? this.formState,
    );
  }
}
