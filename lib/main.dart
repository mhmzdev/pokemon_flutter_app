import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:pokemon_app/blocs/authentication_bloc/authentication_state.dart';
import 'package:pokemon_app/blocs/simple_bloc_observer.dart';
import 'package:pokemon_app/constants.dart';
import 'package:pokemon_app/repository/user_repository.dart';
import 'package:pokemon_app/view/favorite_view.dart';
import 'package:pokemon_app/view/home_view.dart';
import 'package:pokemon_app/view/login_vew.dart';
import 'package:pokemon_app/view/signup_view.dart';
import 'package:pokemon_app/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  final UserRepository userRepository = UserRepository();
  // runApp(
  //   BlocProvider(
  //     create: (context) => AuthenticationBloc(userRepository: userRepository),
  //     child: MyApp(
  //       userRepository: userRepository,
  //     ),
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  const MyApp({
    Key key,
    UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginView(),
        '/signUp': (context) => SignUpView(),
        '/home': (context) => HomeView(),
        '/favorite': (context) => FavoriteView(),
      },
    );
  }
}
