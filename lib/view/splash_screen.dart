import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/animations/entrance_fader.dart';
import 'package:pokemon_app/view/home/home_view.dart';
import 'package:pokemon_app/view/login/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static Page page() => MaterialPage(child: SplashScreen());

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Route depending on the user is already logged into the app or not via Shared Prefs.
  void _authCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _userId = prefs.getString('userId'); // userId from local storage

    Future.delayed(Duration(seconds: 3), () {
      _userId == null
          ? Navigator.of(context).push(LoginPage.route())
          : Navigator.of(context).push(HomeView.route());
    });
  }

  @override
  void initState() {
    _authCheck();
    super.initState();
  }

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
