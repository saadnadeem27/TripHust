import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already done
    final controller = Get.find<SplashController>();
    

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating Particles Background
            ...List.generate(20, (index) {
              return Positioned(
                left: (index % 4) * 100.0,
                top: (index % 5) * 150.0,
                child: TweenAnimationBuilder<double>(
                  duration: Duration(seconds: 3 + (index % 3)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(
                        (index.isEven ? 20 : -20) * value,
                        (index % 3 == 0 ? 30 : -30) * value,
                      ),
                      child: Opacity(
                        opacity: 0.1 + (0.3 * value),
                        child: Container(
                          width: 4 + (index % 3) * 2,
                          height: 4 + (index % 3) * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Enhanced Logo Animation
                        AnimatedBuilder(
                          animation: controller.pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: controller.pulseAnimation.value,
                              child: Opacity(
                                opacity: 1.0,
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppTheme.primaryColor,
                                        AppTheme.secondaryColor,
                                        AppTheme.accentColor,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.4),
                                        blurRadius: 40,
                                        spreadRadius: 8,
                                      ),
                                      BoxShadow(
                                        color: AppTheme.secondaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 4,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Rotating background ring
                                      TweenAnimationBuilder<double>(
                                        duration: const Duration(seconds: 3),
                                        tween: Tween(begin: 0.0, end: 1.0),
                                        builder: (context, rotateValue, child) {
                                          return Transform.rotate(
                                            angle: rotateValue *
                                                6.28, // 2π for full rotation
                                            child: Container(
                                              width: 120,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // Main icon
                                      const Icon(
                                        Icons.flight_takeoff,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        // App Name
                        TweenAnimationBuilder<double>(
                          duration:
                              const Duration(seconds: 1, milliseconds: 500),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => AppTheme
                                      .primaryGradient
                                      .createShader(bounds),
                                  child: Text(
                                    'TripHust',
                                    style: GoogleFonts.poppins(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Tagline
                        TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 2),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Text(
                                'Your Journey Begins Here',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white70,
                                  letterSpacing: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Loading Indicator section (keeping existing code)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        // Animated Dots Loading
                        TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 2),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (index) {
                                  return AnimatedContainer(
                                    duration: Duration(
                                        milliseconds: 300 + (index * 100)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppTheme.primaryColor,
                                          AppTheme.secondaryColor,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.5),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),

                        // Animated Loading Text
                        AnimatedBuilder(
                          animation: controller.fadeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: const Offset(0, 0),
                              child: Opacity(
                                opacity: controller.fadeAnimation.value,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => AppTheme
                                      .primaryGradient
                                      .createShader(bounds),
                                  child: Text(
                                    'Preparing your adventure...',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
