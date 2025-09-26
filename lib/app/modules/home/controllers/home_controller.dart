import 'package:get/get.dart';
import '../../../data/models/destination.dart';
import '../../../data/models/travel_package.dart';
import '../../../data/dummy_data.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  final RxInt selectedBottomNavIndex = 0.obs;
  final RxList<Destination> featuredDestinations = <Destination>[].obs;
  final RxList<TravelPackage> popularPackages = <TravelPackage>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    isLoading.value = true;
    
    // Load dummy data
    featuredDestinations.value = DummyData.destinations.take(6).toList();
    popularPackages.value = DummyData.travelPackages;
    categories.value = DummyData.categories;
    
    isLoading.value = false;
  }

  void changeBottomNav(int index) {
    selectedBottomNavIndex.value = index;
    
    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        Get.toNamed(AppRoutes.EXPLORE);
        break;
      case 2:
        Get.toNamed(AppRoutes.TRAVEL_JOURNAL);
        break;
      case 3:
        Get.toNamed(AppRoutes.PROFILE);
        break;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    // Filter destinations based on category
    if (category == 'All') {
      featuredDestinations.value = DummyData.destinations.take(6).toList();
    } else {
      featuredDestinations.value = DummyData.destinations
          .where((dest) => dest.tags.contains(category))
          .toList();
    }
  }

  void goToDestinationDetail(Destination destination) {
    Get.toNamed(AppRoutes.DESTINATION_DETAIL, arguments: destination);
  }

  void goToSearch() {
    Get.toNamed(AppRoutes.SEARCH);
  }

  void goToNotifications() {
    Get.toNamed(AppRoutes.NOTIFICATIONS);
  }

  void goToItineraryBuilder() {
    Get.toNamed(AppRoutes.ITINERARY_BUILDER);
  }

  void goToARGuide() {
    Get.toNamed(AppRoutes.AR_GUIDE);
  }

  void goToCurrencyConverter() {
    Get.toNamed(AppRoutes.CURRENCY_CONVERTER);
  }

  void goToExpenseTracker() {
    Get.toNamed(AppRoutes.EXPENSE_TRACKER);
  }
}