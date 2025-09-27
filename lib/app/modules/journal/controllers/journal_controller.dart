import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalController extends GetxController {
  // Observable states
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'All'.obs;

  // Filter categories
  final RxList<String> filterCategories = <String>[
    'All',
    'Adventure',
    'Culture',
    'Food',
    'Nature',
    'City',
    'Beach',
    'Mountains'
  ].obs;

  // Computed properties
  List<String> get countriesVisited {
    final countries = journalEntries
        .map((entry) =>
            entry['location']?.toString().split(',').last.trim() ?? '')
        .where((country) => country.isNotEmpty)
        .toSet()
        .toList();
    return countries;
  }

  List<Map<String, dynamic>> get thisMonthEntries {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);

    return journalEntries.where((entry) {
      if (entry['date'] == null) return false;
      try {
        final entryDate = DateTime.parse(entry['date']);
        return entryDate
                .isAfter(currentMonth.subtract(const Duration(days: 1))) &&
            entryDate.isBefore(currentMonth.add(const Duration(days: 32)));
      } catch (e) {
        return false;
      }
    }).toList();
  }

  // Journal entries
  final RxList<Map<String, dynamic>> journalEntries = <Map<String, dynamic>>[
    {
      'id': '1',
      'title': 'Amazing Sunset in Bali',
      'location': 'Tanah Lot Temple, Bali',
      'date': '2024-01-15',
      'rating': 5,
      'photos': [
        'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=400',
        'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=400',
        'https://images.unsplash.com/photo-1555400082-52c0669c5792?w=400',
      ],
      'description':
          'Witnessed one of the most breathtaking sunsets at Tanah Lot Temple. The way the light danced on the water was absolutely magical. This place holds a special place in my heart.',
      'mood': 'excited',
      'weather': 'Sunny',
      'companions': ['Sarah', 'Mike'],
      'tags': ['sunset', 'temple', 'peaceful', 'spiritual'],
      'favorite': true,
    },
    {
      'id': '2',
      'title': 'Paris Night Walk',
      'location': 'Eiffel Tower, Paris',
      'date': '2024-01-10',
      'rating': 4,
      'photos': [
        'https://images.unsplash.com/photo-1543349689-9a4d426bee8e?w=400',
        'https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=400',
      ],
      'description':
          'A romantic evening stroll around the Eiffel Tower. The city lights and the tower\'s golden glow created the perfect atmosphere for unforgettable memories.',
      'mood': 'romantic',
      'weather': 'Cool',
      'companions': ['Emma'],
      'tags': ['romantic', 'citylife', 'lights', 'architecture'],
      'favorite': false,
    },
    {
      'id': '3',
      'title': 'Mountain Adventure',
      'location': 'Swiss Alps, Switzerland',
      'date': '2024-01-05',
      'rating': 5,
      'photos': [
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        'https://images.unsplash.com/photo-1551524164-687a55dd1126?w=400',
        'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=400',
      ],
      'description':
          'Conquered the challenging trails in the Swiss Alps. The pristine snow, fresh mountain air, and stunning panoramic views made every step worth it.',
      'mood': 'adventurous',
      'weather': 'Snowy',
      'companions': ['Solo'],
      'tags': ['mountains', 'hiking', 'snow', 'adventure'],
      'favorite': true,
    },
  ].obs;

  // Current filter and sort options
  final RxString selectedSort = 'recent'.obs;
  final RxBool isGridView = false.obs;

  // Form controllers for new entry
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxList<String> selectedPhotos = <String>[].obs;
  final RxInt selectedRating = 5.obs;
  final RxString selectedMood = 'happy'.obs;
  final RxString selectedWeather = 'Sunny'.obs;
  final RxList<String> companions = <String>[].obs;
  final RxList<String> tags = <String>[].obs;

  // Available options
  final List<String> moods = [
    'happy',
    'excited',
    'romantic',
    'adventurous',
    'peaceful',
    'nostalgic'
  ];
  final List<String> weatherOptions = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Snowy',
    'Windy',
    'Cool'
  ];

  @override
  void onInit() {
    super.onInit();
    _loadJournalEntries();
  }

  @override
  void onClose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void _loadJournalEntries() {
    // Simulate loading journal entries
    print('Loading journal entries...');
  }

  List<Map<String, dynamic>> get filteredEntries {
    List<Map<String, dynamic>> filtered = journalEntries.where((entry) {
      switch (selectedFilter.value) {
        case 'favorites':
          return entry['favorite'] == true;
        case 'recent':
          final entryDate = DateTime.parse(entry['date']);
          final weekAgo = DateTime.now().subtract(const Duration(days: 7));
          return entryDate.isAfter(weekAgo);
        default:
          return true;
      }
    }).toList();

    // Sort entries
    switch (selectedSort.value) {
      case 'recent':
        filtered.sort((a, b) =>
            DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
        break;
      case 'oldest':
        filtered.sort((a, b) =>
            DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
        break;
      case 'rating':
        filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'location':
        filtered.sort((a, b) => a['location'].compareTo(b['location']));
        break;
    }

    return filtered;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void setSort(String sort) {
    selectedSort.value = sort;
  }

  void toggleViewMode() {
    isGridView.toggle();
  }

  void toggleFavorite(Map<String, dynamic> entry) {
    final index = journalEntries.indexWhere((e) => e['id'] == entry['id']);
    if (index != -1) {
      journalEntries[index]['favorite'] = !(entry['favorite'] ?? false);
      journalEntries[index]['isFavorite'] = journalEntries[index]['favorite'];
      journalEntries.refresh();

      Get.snackbar(
        'Journal',
        journalEntries[index]['favorite']
            ? 'Added to favorites'
            : 'Removed from favorites',
        backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void createNewEntry() {
    // Get.to(() => const CreateJournalEntryView()); // Implement when available
    Get.snackbar('Info', 'Create Journal Entry feature coming soon!');
  }

  void editEntry(Map<String, dynamic> entry) {
    // Populate form controllers with entry data
    titleController.text = entry['title'] ?? '';
    locationController.text = entry['location'] ?? '';
    descriptionController.text = entry['description'] ?? '';

    Get.snackbar(
      'Edit Entry',
      'Editing ${entry['title']}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void viewEntry(Map<String, dynamic> entry) {
    // Get.to(() => const ViewJournalEntryView(), arguments: entry); // Implement when available
    Get.snackbar('Info', 'View Journal Entry feature coming soon!');
  }

  void deleteEntry(Map<String, dynamic> entry) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Delete Entry',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${entry['title']}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              journalEntries.removeWhere((e) => e['id'] == entry['id']);
              Get.back();
              Get.snackbar(
                'Journal',
                'Entry deleted successfully',
                backgroundColor: Colors.red.withOpacity(0.8),
                colorText: Colors.white,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void shareEntry(Map<String, dynamic> entry) {
    Get.snackbar(
      'Share',
      'Sharing "${entry['title']}"...',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void addPhotos() {
    // Simulate photo picker
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
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title:
                  const Text('Camera', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                _addFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title:
                  const Text('Gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                _addFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addFromCamera() {
    selectedPhotos.add(
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400');
    Get.snackbar('Photos', 'Photo added from camera');
  }

  void _addFromGallery() {
    selectedPhotos
        .add('https://images.unsplash.com/photo-1551524164-687a55dd1126?w=400');
    Get.snackbar('Photos', 'Photo added from gallery');
  }

  void removePhoto(int index) {
    selectedPhotos.removeAt(index);
  }

  void setRating(int rating) {
    selectedRating.value = rating;
  }

  void setMood(String mood) {
    selectedMood.value = mood;
  }

  void setWeather(String weather) {
    selectedWeather.value = weather;
  }

  void addCompanion(String companion) {
    if (companion.isNotEmpty && !companions.contains(companion)) {
      companions.add(companion);
    }
  }

  void removeCompanion(String companion) {
    companions.remove(companion);
  }

  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  void saveEntry() {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a title',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    final newEntry = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': titleController.text,
      'location': locationController.text,
      'date': DateTime.now().toIso8601String().split('T')[0],
      'rating': selectedRating.value,
      'photos': List<String>.from(selectedPhotos),
      'description': descriptionController.text,
      'mood': selectedMood.value,
      'weather': selectedWeather.value,
      'companions': List<String>.from(companions),
      'tags': List<String>.from(tags),
      'favorite': false,
    };

    journalEntries.insert(0, newEntry);
    _clearForm();

    Get.back();
    Get.snackbar(
      'Journal',
      'Entry saved successfully!',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void _clearForm() {
    titleController.clear();
    locationController.clear();
    descriptionController.clear();
    selectedPhotos.clear();
    selectedRating.value = 5;
    selectedMood.value = 'happy';
    selectedWeather.value = 'Sunny';
    companions.clear();
    tags.clear();
  }

  void exportJournal() {
    Get.snackbar(
      'Export',
      'Exporting journal as PDF...',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void searchJournal(String query) {
    if (query.isEmpty) {
      selectedFilter.value = 'all';
      return;
    }

    // Filter entries based on search query
    final filtered = journalEntries.where((entry) {
      return entry['title'].toLowerCase().contains(query.toLowerCase()) ||
          entry['location'].toLowerCase().contains(query.toLowerCase()) ||
          entry['description'].toLowerCase().contains(query.toLowerCase()) ||
          entry['tags']
              .any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    journalEntries.assignAll(filtered);
  }

  String getMoodEmoji(String mood) {
    switch (mood) {
      case 'happy':
        return '😊';
      case 'excited':
        return '🤩';
      case 'romantic':
        return '😍';
      case 'adventurous':
        return '🏔️';
      case 'peaceful':
        return '😌';
      case 'nostalgic':
        return '🥰';
      default:
        return '😊';
    }
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'happy':
        return Colors.yellow;
      case 'excited':
        return Colors.orange;
      case 'romantic':
        return Colors.pink;
      case 'adventurous':
        return Colors.green;
      case 'peaceful':
        return Colors.blue;
      case 'nostalgic':
        return Colors.purple;
      default:
        return Colors.yellow;
    }
  }

  // New methods for the enhanced UI
  void openSearchDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Search Entries',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search by title, location, or tags...',
            hintStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (query) {
            // Implement search logic
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void addNewEntry() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: Get.width * 0.9,
          height: Get.height * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0A0A0A),
                Color(0xFF1A1A2E),
                Color(0xFF16213E),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'New Journal Entry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveNewEntry();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  void _saveNewEntry() {
    if (titleController.text.isNotEmpty) {
      final newEntry = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': titleController.text,
        'location': locationController.text,
        'date': DateTime.now().toString().split(' ')[0],
        'rating': selectedRating.value,
        'photos': selectedPhotos.toList(),
        'description': descriptionController.text,
        'mood': selectedMood.value,
        'weather': selectedWeather.value,
        'companions': companions.toList(),
        'tags': ['new'],
        'favorite': false,
        'imageUrl':
            'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400',
        'category': 'General',
        'content': descriptionController.text,
        'readTime': 3,
        'isFavorite': false,
      };

      journalEntries.insert(0, newEntry);

      // Clear form
      titleController.clear();
      locationController.clear();
      descriptionController.clear();
      selectedPhotos.clear();

      Get.snackbar(
        'Success',
        'New entry added successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
