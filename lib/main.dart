import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/constants.dart';
import 'package:pokemon_app/view/favorite_view.dart';
import 'package:pokemon_app/view/home_view.dart';
import 'package:pokemon_app/view/login_vew.dart';
import 'package:pokemon_app/view/signup_view.dart';
import 'package:pokemon_app/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// MVC Architecture Followed!
/// bloc implementation ==> bloc branch at GIT
/// https://github.com/mhmzdev/pokemon_flutter_app

class MyApp extends StatelessWidget {
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
