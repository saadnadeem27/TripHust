import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../onboarding/views/onboarding_view.dart';
import '../../auth/views/login_view.dart';
import '../../home/views/home_view.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController pulseController;
  late AnimationController fadeController;
  late Animation<double> pulseAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    print('SplashController initialized');
    _initAnimations();
    _startAnimations();
    _navigateToNext();
  }

  void _initAnimations() {
    // Pulse animation for the logo
    pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: pulseController,
      curve: Curves.easeInOut,
    ));

    // Fade animation for loading text
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    // Start pulse animation (repeat)
    pulseController.repeat(reverse: true);

    // Start fade animation (repeat)
    fadeController.repeat(reverse: true);
  }

  void _navigateToNext() {
    print('Starting navigation timer...');
    Future.delayed(const Duration(seconds: 4), () async {
      print('Stopping animations...');
      pulseController.stop();
      fadeController.stop();

      print('Navigating to onboarding...');
      try {
        // Try to navigate to onboarding first
        Get.off(() => const OnboardingView());
      } catch (e) {
        print('Error navigating to onboarding: $e');
        // If onboarding fails, try to go to login
        try {
          Get.off(() => const LoginView());
        } catch (e2) {
          print('Error navigating to login: $e2');
          // If all fails, go to home
          Get.off(() => const HomeView());
        }
      }
    });
  }

  @override
  void onClose() {
    pulseController.dispose();
    fadeController.dispose();
    super.onClose();
  }
}
