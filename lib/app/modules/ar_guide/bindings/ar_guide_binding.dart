import 'package:get/get.dart';
import '../controllers/ar_guide_controller.dart';

class ARGuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ARGuideController>(() => ARGuideController());
  }
}
