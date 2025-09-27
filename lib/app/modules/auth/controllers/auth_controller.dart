import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';
import '../../home/bindings/home_binding.dart';
import '../views/register_view.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  final RxBool rememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  Future<void> login() async {
    // if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    // Ensure HomeController is registered before navigation
    HomeBinding().dependencies();
    Get.offAll(() => const HomeView(), binding: HomeBinding());
    // }
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Registration successful!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

  HomeBinding().dependencies();
  Get.offAll(() => const HomeView(), binding: HomeBinding());
    }
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;

    // Simulate Google login
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    Get.snackbar(
      'Success',
      'Google login successful!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

  HomeBinding().dependencies();
  Get.offAll(() => const HomeView(), binding: HomeBinding());
  }

  Future<void> loginWithApple() async {
    isLoading.value = true;

    // Simulate Apple login
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    Get.snackbar(
      'Success',
      'Apple login successful!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

  HomeBinding().dependencies();
  Get.offAll(() => const HomeView(), binding: HomeBinding());
  }

  void goToRegister() {
    Get.to(() => const RegisterView());
  }

  void goToLogin() {
    Get.back();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
