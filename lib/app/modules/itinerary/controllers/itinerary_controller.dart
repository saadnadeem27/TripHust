import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItineraryController extends GetxController {
  final RxList<Map<String, dynamic>> itineraries = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> currentItinerary = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedTab = 'My Trips'.obs;
  final RxInt selectedDay = 0.obs;
  
  // Form controllers
  final TextEditingController tripNameController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  
  // Date selection
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);
  
  final List<String> tabs = ['My Trips', 'Templates', 'Shared'];
  
  @override
  void onInit() {
    super.onInit();
    loadItineraries();
  }
  
  @override
  void onClose() {
    tripNameController.dispose();
    destinationController.dispose();
    budgetController.dispose();
    super.onClose();
  }
  
  void loadItineraries() {
    isLoading.value = true;
    
    // Simulate loading data
    Future.delayed(const Duration(seconds: 1), () {
      itineraries.value = [
        {
          'id': '1',
          'title': 'Paris Adventure',
          'destination': 'Paris, France',
          'startDate': '2024-02-15',
          'endDate': '2024-02-22',
          'budget': 2500.0,
          'spent': 1200.0,
          'status': 'active',
          'image': 'https://images.unsplash.com/photo-1543349689-9a4d426bee8e?w=400',
          'days': [
            {
              'date': '2024-02-15',
              'activities': [
                {'time': '09:00', 'title': 'Arrival at CDG Airport', 'type': 'transport'},
                {'time': '11:00', 'title': 'Check-in at Hotel Le Marais', 'type': 'accommodation'},
                {'time': '14:00', 'title': 'Lunch at Café de Flore', 'type': 'food'},
                {'time': '16:00', 'title': 'Visit Louvre Museum', 'type': 'activity'},
              ]
            },
            {
              'date': '2024-02-16',
              'activities': [
                {'time': '09:00', 'title': 'Breakfast at hotel', 'type': 'food'},
                {'time': '10:30', 'title': 'Climb Eiffel Tower', 'type': 'activity'},
                {'time': '13:00', 'title': 'Seine River Cruise', 'type': 'activity'},
                {'time': '19:00', 'title': 'Dinner at Le Jules Verne', 'type': 'food'},
              ]
            }
          ]
        },
        {
          'id': '2',
          'title': 'Tokyo Discovery',
          'destination': 'Tokyo, Japan',
          'startDate': '2024-03-10',
          'endDate': '2024-03-17',
          'budget': 3200.0,
          'spent': 0.0,
          'status': 'planning',
          'image': 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
          'days': [
            {
              'date': '2024-03-10',
              'activities': [
                {'time': '14:00', 'title': 'Arrival at Narita Airport', 'type': 'transport'},
                {'time': '16:00', 'title': 'Check-in at Shibuya Hotel', 'type': 'accommodation'},
                {'time': '19:00', 'title': 'Dinner in Shibuya', 'type': 'food'},
              ]
            }
          ]
        }
      ];
      isLoading.value = false;
    });
  }
  
  void selectTab(String tab) {
    selectedTab.value = tab;
  }
  
  void selectDay(int dayIndex) {
    selectedDay.value = dayIndex;
  }
  
  void createNewTrip() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: Get.width * 0.9,
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Create New Trip',
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
              TextField(
                controller: tripNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Trip Name',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: destinationController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectStartDate(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          startDate.value != null 
                              ? '${startDate.value!.day}/${startDate.value!.month}/${startDate.value!.year}'
                              : 'Start Date',
                          style: TextStyle(
                            color: startDate.value != null ? Colors.white : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectEndDate(),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          endDate.value != null 
                              ? '${endDate.value!.day}/${endDate.value!.month}/${endDate.value!.year}'
                              : 'End Date',
                          style: TextStyle(
                            color: endDate.value != null ? Colors.white : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (tripNameController.text.isNotEmpty && 
                            destinationController.text.isNotEmpty &&
                            startDate.value != null && 
                            endDate.value != null) {
                          _saveNewTrip();
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Create'),
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
  
  void _selectStartDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      startDate.value = picked;
    }
  }
  
  void _selectEndDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: startDate.value ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: startDate.value ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      endDate.value = picked;
    }
  }
  
  void _saveNewTrip() {
    final newTrip = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': tripNameController.text,
      'destination': destinationController.text,
      'startDate': startDate.value!.toIso8601String().split('T')[0],
      'endDate': endDate.value!.toIso8601String().split('T')[0],
      'budget': double.tryParse(budgetController.text) ?? 0.0,
      'spent': 0.0,
      'status': 'planning',
      'image': 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400',
      'days': []
    };
    
    itineraries.insert(0, newTrip);
    
    // Clear form
    tripNameController.clear();
    destinationController.clear();
    budgetController.clear();
    startDate.value = null;
    endDate.value = null;
    
    Get.snackbar(
      'Success',
      'Trip created successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void editTrip(Map<String, dynamic> trip) {
    Get.snackbar(
      'Edit Trip',
      'Editing ${trip['title']}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void deleteTrip(String tripId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text('Delete Trip', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to delete this trip? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              itineraries.removeWhere((trip) => trip['id'] == tripId);
              Get.back();
              Get.snackbar(
                'Deleted',
                'Trip deleted successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  
  void viewTripDetails(Map<String, dynamic> trip) {
    currentItinerary.value = trip['days'] ?? [];
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  trip['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
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
            Text(
              trip['destination'],
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
            if (currentItinerary.isNotEmpty) ...[
              const Text(
                'Daily Itinerary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: currentItinerary.length,
                      itemBuilder: (context, dayIndex) {
                        final day = currentItinerary[dayIndex];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Day ${dayIndex + 1} - ${day['date']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...((day['activities'] as List).map((activity) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          activity['time'],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            activity['title'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )).toList()),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ] else ...[
              const Center(
                child: Text(
                  'No itinerary planned yet',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Color getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'planning':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
  
  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Active';
      case 'planning':
        return 'Planning';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}