import 'package:flutter/widgets.dart';
import 'package:pokemon_app/app/bloc/app_bloc.dart';
import 'package:pokemon_app/view/splash_screen.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [SplashScreen.page()];
    case AppStatus.unauthenticated:
    default:
      return [SplashScreen.page()];
  }
}
