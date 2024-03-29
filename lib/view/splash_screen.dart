import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/animations/entrance_fader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _authCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String _userId = prefs.getString('userId');
    Future.delayed(Duration(seconds: 3), () {
      _userId == null
          ? Navigator.pushReplacementNamed(context, '/login')
          : Navigator.pushReplacementNamed(context, '/home');
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
