import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/constants.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: SvgPicture.asset(
            'assets/pokeball.svg',
            height: 40.0,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "Loading...",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        )
      ],
    );
  }
}
