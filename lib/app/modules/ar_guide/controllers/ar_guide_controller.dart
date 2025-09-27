import 'package:get/get.dart';

class ARGuideController extends GetxController {
  final RxBool isARActive = false.obs;
  final RxBool isLocationPermissionGranted = false.obs;
  final RxBool isCameraPermissionGranted = false.obs;
  final RxList<Map<String, dynamic>> nearbyPoints = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissions();
    loadNearbyPoints();
  }

  void checkPermissions() async {
    // Simulate permission checks
    await Future.delayed(const Duration(seconds: 1));
    isLocationPermissionGranted.value = true;
    isCameraPermissionGranted.value = true;
  }

  void loadNearbyPoints() {
    // Simulate loading nearby AR points
    nearbyPoints.value = [
      {
        'id': '1',
        'name': 'Central Park',
        'distance': 0.2,
        'type': 'park',
        'description': 'Beautiful urban park with lakes and trails',
      },
      {
        'id': '2',
        'name': 'Museum of Natural History',
        'distance': 0.5,
        'type': 'museum',
        'description': 'World-renowned natural history museum',
      },
      {
        'id': '3',
        'name': 'Local Coffee Shop',
        'distance': 0.1,
        'type': 'restaurant',
        'description': 'Cozy cafe with excellent coffee',
      },
    ];
  }

  void startARSession() {
    if (isLocationPermissionGranted.value && isCameraPermissionGranted.value) {
      isARActive.value = true;
      Get.snackbar(
        'AR Guide',
        'AR session started! Point your camera to discover nearby places.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } else {
      Get.snackbar(
        'Permission Required',
        'Please grant camera and location permissions to use AR features.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  void stopARSession() {
    isARActive.value = false;
    Get.snackbar(
      'AR Guide',
      'AR session stopped.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void selectARPoint(Map<String, dynamic> point) {
    Get.snackbar(
      point['name'],
      point['description'],
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void openQRScanner() {
    Get.snackbar(
      'QR Scanner',
      'QR Scanner feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void openTranslator() {
    Get.snackbar(
      'AR Translator',
      'AR Translator feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void openDirections() {
    Get.snackbar(
      'AR Directions',
      'AR Directions feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}