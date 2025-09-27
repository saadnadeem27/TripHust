import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/views/login_view.dart';
import '../../auth/bindings/auth_binding.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Discover Amazing Places',
      'description':
          'Explore the world\'s most beautiful destinations with our curated travel guides and recommendations.',
      'image':
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800',
    },
    {
      'title': 'Smart Trip Planning',
      'description':
          'AI-powered itinerary builder creates perfect trips based on your preferences and budget.',
      'image':
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
    },
    {
      'title': 'Augmented Reality Guide',
      'description':
          'Point your phone at landmarks to get instant information and historical insights.',
      'image':
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
    },
  ];

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skip() {
    goToLogin();
  }

  void goToLogin() {
    // Use binding parameter so AuthBinding runs when the route is pushed
    Get.off(
      () => const LoginView(),
      binding: AuthBinding(),
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
