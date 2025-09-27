import 'package:get/get.dart';
import '../../../data/models/destination.dart';
import '../../../data/models/travel_package.dart';
import '../../../data/dummy_data.dart';
import '../../explore/views/explore_view.dart';
import '../../journal/views/travel_journal_view.dart';
import '../../profile/views/profile_view.dart';
import '../../destination/views/destination_detail_view.dart';
import '../../itinerary/views/itinerary_builder_view.dart';

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
        Get.to(() => const ExploreView());
        break;
      case 2:
        Get.to(() => const TravelJournalView());
        break;
      case 3:
        Get.to(() => const ProfileView());
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
    Get.to(() => const DestinationDetailView(), arguments: destination);
  }

  void goToSearch() {
    // Get.to(() => const SearchView()); // Implement when SearchView is available
    Get.snackbar('Info', 'Search feature coming soon!');
  }

  void goToNotifications() {
    // Get.to(() => const NotificationsView()); // Implement when available
    Get.snackbar('Info', 'Notifications feature coming soon!');
  }

  void goToItineraryBuilder() {
    Get.to(() => const ItineraryBuilderView());
  }

  void goToARGuide() {
    // Get.to(() => const ARGuideView()); // Implement when available
    Get.snackbar('Info', 'AR Guide feature coming soon!');
  }

  void goToCurrencyConverter() {
    // Get.to(() => const CurrencyConverterView()); // Implement when available
    Get.snackbar('Info', 'Currency Converter feature coming soon!');
  }

  void goToExpenseTracker() {
    // Get.to(() => const ExpenseTrackerView()); // Implement when available
    Get.snackbar('Info', 'Expense Tracker feature coming soon!');
  }
}
