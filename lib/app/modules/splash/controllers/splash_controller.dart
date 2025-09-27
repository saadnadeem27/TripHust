import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:trip_hust/app/modules/onboarding/views/onboarding_view.dart";
import "package:trip_hust/app/modules/onboarding/controllers/onboarding_controller.dart";

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController pulseController;
  late AnimationController fadeController;
  late Animation<double> pulseAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    print("SplashController initialized");
    _initAnimations();
    _startAnimations();
    _navigateToNext();
  }

  void _initAnimations() {
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
    pulseController.repeat(reverse: true);
    fadeController.repeat(reverse: true);
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 4), () {
      pulseController.stop();
      fadeController.stop();
      print("Navigating to next screen");
      
      try {
        // Put the controller immediately to make it available
        Get.put<OnboardingController>(OnboardingController(), permanent: false);
        Get.off(() => const OnboardingView());
        print("Successfully navigated to onboarding");
      } catch (e) {
        print("Error navigating: $e");
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
