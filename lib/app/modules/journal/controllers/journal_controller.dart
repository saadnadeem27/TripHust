import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalController extends GetxController {
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
  final RxString selectedFilter = 'all'.obs;
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

  void toggleFavorite(String entryId) {
    final index = journalEntries.indexWhere((entry) => entry['id'] == entryId);
    if (index != -1) {
      journalEntries[index]['favorite'] = !journalEntries[index]['favorite'];
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

  void editEntry(String entryId) {
    // Get.to(() => const EditJournalEntryView(), arguments: entryId); // Implement when available
    Get.snackbar('Info', 'Edit Journal Entry feature coming soon!');
  }

  void viewEntry(Map<String, dynamic> entry) {
    // Get.to(() => const ViewJournalEntryView(), arguments: entry); // Implement when available
    Get.snackbar('Info', 'View Journal Entry feature coming soon!');
  }

  void deleteEntry(String entryId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Delete Entry',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this journal entry?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              journalEntries.removeWhere((entry) => entry['id'] == entryId);
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
}
