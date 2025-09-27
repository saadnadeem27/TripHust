import 'package:get/get.dart';
import '../../../data/models/destination.dart';
import '../../../data/models/travel_package.dart';
import '../../../data/dummy_data.dart';
import '../../explore/views/explore_view.dart';
import '../../explore/bindings/explore_binding.dart';
import '../../journal/views/travel_journal_view.dart';
import '../../journal/bindings/journal_binding.dart';
import '../../profile/views/profile_view.dart';
import '../../profile/bindings/profile_binding.dart';
import '../../destination/views/destination_detail_view.dart';
import '../../destination/bindings/destination_binding.dart';
import '../../itinerary/views/itinerary_builder_view.dart';
import '../../itinerary/bindings/itinerary_binding.dart';
import '../../packages/views/popular_packages_view.dart';
import '../../ar_guide/views/ar_guide_view.dart';
import '../../ar_guide/bindings/ar_guide_binding.dart';
import '../../currency_converter/views/currency_converter_view.dart';
import '../../currency_converter/bindings/currency_converter_binding.dart';
import '../../expense_tracker/views/expense_tracker_view.dart';
import '../../expense_tracker/bindings/expense_tracker_binding.dart';

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
    // Just update the index, the view will handle showing different content
  }

  // Navigation methods for non-bottom nav screens
  void navigateToExplore() {
    Get.to(() => const ExploreView(), binding: ExploreBinding());
  }

  void navigateToJournal() {
    Get.to(() => const TravelJournalView(), binding: JournalBinding());
  }

  void navigateToProfile() {
    Get.to(() => const ProfileView(), binding: ProfileBinding());
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
    Get.to(() => const DestinationDetailView(),
        arguments: destination, binding: DestinationBinding());
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
    Get.to(() => const ItineraryBuilderView(), binding: ItineraryBinding());
  }

  void goToARGuide() {
    Get.to(() => const ARGuideView(), binding: ARGuideBinding());
  }

  void goToCurrencyConverter() {
    Get.to(() => const CurrencyConverterView(),
        binding: CurrencyConverterBinding());
  }

  void goToExpenseTracker() {
    Get.to(() => const ExpenseTrackerView(), binding: ExpenseTrackerBinding());
  }

  void goToPopularPackages() {
    Get.to(() => const PopularPackagesView());
  }
}
