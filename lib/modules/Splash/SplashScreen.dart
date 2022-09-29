import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/Login/LoginScreen.dart';
import 'package:shop/modules/onBoarding.dart';
import 'package:shop/shared/components/constants.dart';

import '../Layout/HomeScreen.dart';

class SplashScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/splash.jpg',
      splashIconSize: 230,
      nextScreen: onBoardingScreen(),
      splashTransition: SplashTransition.rotationTransition,
     // pageTransitionType: PageTransitionType.scale,
    );
    throw UnimplementedError();
  }

}

//(onBoarding==null)?onBoardingScreen():(token!=null)?LoginScreen():HomeScreen()