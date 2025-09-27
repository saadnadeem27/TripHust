import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/views/login_view.dart';

class ProfileController extends GetxController {
  // User profile data
  final RxString userName = 'John Traveler'.obs;
  final RxString userEmail = 'john.traveler@triphust.com'.obs;
  final RxString userPhone = '+1 234 567 8900'.obs;
  final RxString userLocation = 'New York, USA'.obs;
  final RxString profileImage =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400'.obs;

  // User stats
  final RxInt totalTrips = 12.obs;
  final RxInt totalCountries = 8.obs;
  final RxInt totalCities = 25.obs;
  final RxInt totalPhotos = 156.obs;

  // User preferences
  final RxBool isDarkMode = true.obs;
  final RxBool notificationsEnabled = true.obs;
  final RxBool locationEnabled = true.obs;
  final RxString currency = 'USD'.obs;
  final RxString language = 'English'.obs;

  // Membership info
  final RxString membershipType = 'Premium'.obs;
  final RxString membershipExpiry = 'Dec 2024'.obs;
  final RxInt loyaltyPoints = 2450.obs;

  // Recent activities
  final RxList<Map<String, dynamic>> recentActivities = <Map<String, dynamic>>[
    {
      'type': 'booking',
      'title': 'Booked Bali Adventure',
      'date': '2 days ago',
      'icon': 'flight_takeoff',
    },
    {
      'type': 'review',
      'title': 'Reviewed Paris Tour',
      'date': '5 days ago',
      'icon': 'star',
    },
    {
      'type': 'photo',
      'title': 'Added 10 new photos',
      'date': '1 week ago',
      'icon': 'photo_camera',
    },
    {
      'type': 'achievement',
      'title': 'Earned Explorer Badge',
      'date': '2 weeks ago',
      'icon': 'emoji_events',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    // Simulate loading user data
    print('Loading user profile data...');
  }

  void updateProfile() {
    Get.snackbar(
      'Profile',
      'Profile updated successfully!',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Get.theme.colorScheme.onPrimary,
    );
  }

  void changeProfilePicture() {
    // Simulate camera/gallery picker
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildBottomSheetItem('Camera', Icons.camera_alt, () {
              Get.back();
              _selectFromCamera();
            }),
            _buildBottomSheetItem('Gallery', Icons.photo_library, () {
              Get.back();
              _selectFromGallery();
            }),
            _buildBottomSheetItem('Remove Photo', Icons.delete, () {
              Get.back();
              _removeProfilePicture();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetItem(
      String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  void _selectFromCamera() {
    Get.snackbar('Camera', 'Opening camera...');
  }

  void _selectFromGallery() {
    Get.snackbar('Gallery', 'Opening gallery...');
  }

  void _removeProfilePicture() {
    profileImage.value = '';
    Get.snackbar('Profile', 'Profile picture removed');
  }

  void editProfile() {
    // Get.to(() => const EditProfileView()); // Implement when available
    Get.snackbar('Info', 'Edit Profile feature coming soon!');
  }

  void viewTravelHistory() {
    // Get.to(() => const TravelHistoryView()); // Implement when available
    Get.snackbar('Info', 'Travel History feature coming soon!');
  }

  void manageBookings() {
    // Get.to(() => const MyBookingsView()); // Implement when available
    Get.snackbar('Info', 'My Bookings feature coming soon!');
  }

  void viewFavorites() {
    // Get.to(() => const FavoritesView()); // Implement when available
    Get.snackbar('Info', 'Favorites feature coming soon!');
  }

  void openSettings() {
    // Get.to(() => const SettingsView()); // Implement when available
    Get.snackbar('Info', 'Settings feature coming soon!');
  }

  void contactSupport() {
    Get.snackbar(
      'Support',
      'Opening support chat...',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void shareApp() {
    Get.snackbar(
      'Share',
      'Sharing TripHust app...',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void rateApp() {
    Get.snackbar(
      'Rate App',
      'Opening app store...',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAll(() => const LoginView());
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications() {
    notificationsEnabled.toggle();
    Get.snackbar(
      'Notifications',
      notificationsEnabled.value
          ? 'Notifications enabled'
          : 'Notifications disabled',
    );
  }

  void toggleLocation() {
    locationEnabled.toggle();
    Get.snackbar(
      'Location',
      locationEnabled.value
          ? 'Location services enabled'
          : 'Location services disabled',
    );
  }

  void changeCurrency() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Currency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...['USD', 'EUR', 'GBP', 'JPY', 'AUD'].map(
              (curr) => ListTile(
                title: Text(curr, style: const TextStyle(color: Colors.white)),
                trailing: currency.value == curr
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  currency.value = curr;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeLanguage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...['English', 'Spanish', 'French', 'German', 'Japanese'].map(
              (lang) => ListTile(
                title: Text(lang, style: const TextStyle(color: Colors.white)),
                trailing: language.value == lang
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  language.value = lang;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
