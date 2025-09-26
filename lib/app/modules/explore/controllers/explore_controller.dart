import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/destination.dart';
import '../../../data/dummy_data.dart';
import '../../../routes/app_routes.dart';

class ExploreController extends GetxController {
  final searchController = TextEditingController();
  final RxList<Destination> allDestinations = <Destination>[].obs;
  final RxList<Destination> filteredDestinations = <Destination>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isMapView = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDestinations();
  }

  void loadDestinations() {
    isLoading.value = true;

    // Load dummy data
    allDestinations.value = DummyData.destinations;
    filteredDestinations.value = DummyData.destinations;
    categories.value = DummyData.categories;

    isLoading.value = false;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    _filterDestinations();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _filterDestinations();
  }

  void _filterDestinations() {
    List<Destination> filtered = allDestinations;

    // Filter by category
    if (selectedCategory.value != 'All') {
      filtered = filtered
          .where((dest) => dest.tags.contains(selectedCategory.value))
          .toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((dest) =>
              dest.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              dest.city
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              dest.country
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    filteredDestinations.value = filtered;
  }

  void toggleMapView() {
    isMapView.value = !isMapView.value;
    Get.snackbar(
      'Map View',
      isMapView.value ? 'Map view enabled' : 'Grid view enabled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filter Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Advanced filters coming soon!',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void toggleFavorite(Destination destination) {
    final index = allDestinations.indexWhere((d) => d.id == destination.id);
    if (index != -1) {
      allDestinations[index] = destination.copyWith(
        isFavorite: !destination.isFavorite,
      );
      _filterDestinations();
    }

    Get.snackbar(
      destination.isFavorite ? 'Removed from Favorites' : 'Added to Favorites',
      destination.name,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void goToDestinationDetail(Destination destination) {
    Get.toNamed(AppRoutes.DESTINATION_DETAIL, arguments: destination);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
