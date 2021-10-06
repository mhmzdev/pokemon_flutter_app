import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubits/auth/auth_cubit.dart';
import 'package:pokemon_app/view/signUp/signup_view.dart';

class SignUpPage extends StatelessWidget {
  static Route route() {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 750),
        reverseTransitionDuration: Duration(milliseconds: 750),
        transitionsBuilder: (context, ani1, ani2, child) {
          return FadeTransition(
            child: child,
            opacity: ani1,
          );
        },
        pageBuilder: (context, a1, a2) => SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: SignUpView(),
    );
  }
}
