import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/view/login/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/view/login/view/login_view.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
      child: LoginView(),
    );
  }
}
