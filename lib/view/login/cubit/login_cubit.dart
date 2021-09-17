import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(LoginState());

  Future login() async {
    try {
      var value = await _authenticationRepository.login(
        email: state.email,
        password: state.password,
      );
      if (value is String) return value;
    } catch (e) {
      print(e.toString());
    }
  }
}
