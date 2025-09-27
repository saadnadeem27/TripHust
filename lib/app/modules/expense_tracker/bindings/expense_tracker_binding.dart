import 'package:get/get.dart';
import '../controllers/expense_tracker_controller.dart';

class ExpenseTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseTrackerController>(() => ExpenseTrackerController());
  }
}
