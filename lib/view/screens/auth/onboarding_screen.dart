import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:smart_delivery/view/screens/auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Explore Menus',
      subTitle: 'Browse through diverse menus and order directly from the app',
      imageUrl: 'assets/onboard/onbo1.jpeg',
      titleTextStyle: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w600,
      ),
    ),
    Introduction(
      title: 'Fast Delivery',
      subTitle: 'Your orders will be promptly delivered to your doorstep',
      imageUrl: 'assets/onboard/onbo2.jpeg',
      titleTextStyle: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w600,
      ),
    ),
    Introduction(
      title: 'Secure Payments',
      subTitle: 'Enjoy secure transactions and convenient payment options',
      imageUrl: 'assets/onboard/onbo3.jpeg',
      titleTextStyle: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w600,
      ),
    ),
    Introduction(
      title: 'Get Started',
      subTitle: 'Start ordering now and experience hassle-free food delivery',
      imageUrl: 'assets/onboard/onbo4.jpeg',
      titleTextStyle: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w600,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      foregroundColor: Colors.blue,
        introductionList: list,
        onTapSkipButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ), //MaterialPageRoute
          );
        }
    );
  }
}
