import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpCubit(this._authenticationRepository) : super(SignUpState());

  Future<void> signUp() async {
    try {
      var value = await _authenticationRepository.signUp(
        email: state.email,
        password: state.password,
      );
      if (value is String) return value;
    } on Exception {
      throw "Sign Up Err!";
    }
  }
}
