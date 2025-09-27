import 'package:get/get.dart';
import '../controllers/currency_converter_controller.dart';

class CurrencyConverterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrencyConverterController>(
        () => CurrencyConverterController());
  }
}
