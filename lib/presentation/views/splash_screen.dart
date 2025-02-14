import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => MainScreen());
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'Flutter Assignment',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}