import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../explore/controllers/explore_controller.dart';
import '../../journal/controllers/journal_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ExploreController>(
      () => ExploreController(),
    );
    Get.lazyPut<JournalController>(
      () => JournalController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
