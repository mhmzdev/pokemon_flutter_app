import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/app_routes.dart';
import 'package:pokemon_app/cubits/auth/auth_cubit.dart';
import 'package:pokemon_app/view/favorites/favorite_view.dart';
import 'package:pokemon_app/view/home/home_view.dart';
import 'package:pokemon_app/view/login/login_page.dart';
import 'package:pokemon_app/view/signUp/signup_page.dart';
import 'package:pokemon_app/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: AppRoutes.login,
        routes: <String, WidgetBuilder>{
          AppRoutes.splash: (context) => SplashScreen(),
          AppRoutes.login: (context) => LoginPage(),
          AppRoutes.signUp: (context) => SignUpPage(),
          AppRoutes.home: (context) => HomeView(),
          AppRoutes.favorite: (context) => FavoriteView(),
        },
      ),
    );
  }
}
