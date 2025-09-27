import 'package:get/get.dart';
import '../../../data/models/destination.dart';
import '../../booking/views/booking_view.dart';

class DestinationController extends GetxController {
  late Destination destination;
  final RxInt selectedImageIndex = 0.obs;
  final RxBool isFavorite = false.obs;
  final RxBool isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    destination = Get.arguments as Destination;
    isFavorite.value = destination.isFavorite;
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Get.snackbar(
      isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
      destination.name,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
    Get.snackbar(
      isBookmarked.value ? 'Bookmarked' : 'Bookmark Removed',
      destination.name,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void bookNow() {
    Get.to(() => const BookingView(), arguments: destination);
  }

  void shareDestination() {
    Get.snackbar(
      'Share',
      'Sharing ${destination.name}...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void viewOnMap() {
    Get.snackbar(
      'Map',
      'Opening ${destination.name} on map...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void checkWeather() {
    Get.snackbar(
      'Weather',
      'Current weather: ${destination.weather}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
