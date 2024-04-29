import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      controller.checkUserLoginStatus();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AnimatedLogo(),
            const SizedBox(height: 20),
            const Center(
              child: Text.rich(
                TextSpan(
                  text: 'T4sk ',
                  style: TextStyle(
                      fontFamily: 'Poppinss', color: Colors.blue, fontSize: 24),
                  children: [
                    TextSpan(
                      text: '% ',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.green,
                          fontSize: 24),
                    ),
                    TextSpan(
                      text: 'Sc0r3',
                      style: TextStyle(
                          fontFamily: 'Poppinss',
                          color: Colors.red,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.blue.shade400,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 3),
      tween: Tween<double>(begin: 1.0, end: 2.3),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Image.asset(
            'assets/images/logo_horizontal_color.png',
            width: 150,
            height: 150,
          ),
        );
      },
    );
  }
}
