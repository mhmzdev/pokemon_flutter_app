import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/animations/entrance_fader.dart';
import 'package:pokemon_app/app_routes.dart';
import 'package:pokemon_app/cubits/auth/auth_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            // auth check
            Builder(builder: (context) {
              final authCubit = BlocProvider.of<AuthCubit>(context);
              WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
                if (authCubit.state is AuthLoginCheck) {
                  authCubit.init();
                }
                if (authCubit.state is AuthLoginCheck) {
                  Navigator.pushReplacementNamed(
                    context,
                    authCubit.state.userId == null
                        ? AppRoutes.login
                        : AppRoutes.home,
                  );
                }
              });
              return Container();
            }),

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
        ),
      ),
    );
  }
}
