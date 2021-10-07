import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/animations/entrance_fader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/app_routes.dart';
import 'package:pokemon_app/cubits/auth/auth_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                print("INIT STATE!");
                AuthCubit().init();
              }
              if (state is AuthLoginCheck) {
                print("AUTH STATE!");
                Navigator.pushNamed(context,
                    state.userId != null ? AppRoutes.home : AppRoutes.login);
              }
            },
            builder: (context, state) {
              return _initialBuild();
            },
          ),
        ),
      ),
    );
  }

  Widget _initialBuild() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EntranceFader(
            offset: Offset(0, 20),
            duration: Duration(milliseconds: 1500),
            child: SvgPicture.asset(
              'assets/pokeball.svg',
              height: 150.0,
            ),
          ),
          const SizedBox(height: 25.0),
          const Text(
            "Welcome To",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            "Pokemon App",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ],
      );
}
