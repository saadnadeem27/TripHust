import 'package:get/get.dart';

class ExpenseTrackerController extends GetxController {
  final RxDouble totalBudget = 0.0.obs;
  final RxDouble totalExpenses = 0.0.obs;
  final RxList<Map<String, dynamic>> expenses = <Map<String, dynamic>>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isLoading = false.obs;

  final List<String> categories = [
    'All',
    'Transportation',
    'Accommodation',
    'Food & Dining',
    'Entertainment',
    'Shopping',
    'Activities',
    'Other',
  ];

  final Map<String, Map<String, dynamic>> categoryIcons = {
    'Transportation': {'icon': '🚗', 'color': 'blue'},
    'Accommodation': {'icon': '🏨', 'color': 'green'},
    'Food & Dining': {'icon': '🍽️', 'color': 'orange'},
    'Entertainment': {'icon': '🎭', 'color': 'purple'},
    'Shopping': {'icon': '🛍️', 'color': 'pink'},
    'Activities': {'icon': '🎯', 'color': 'cyan'},
    'Other': {'icon': '💳', 'color': 'grey'},
  };

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
    calculateTotals();
  }

  void loadExpenses() {
    expenses.value = [
      {
        'id': '1',
        'title': 'Hotel Booking',
        'amount': 120.50,
        'category': 'Accommodation',
        'date': '2024-01-20',
        'description': 'Grand Hotel Paris - 2 nights',
      },
      {
        'id': '2',
        'title': 'Flight Tickets',
        'amount': 450.00,
        'category': 'Transportation',
        'date': '2024-01-19',
        'description': 'Round trip tickets to Paris',
      },
      {
        'id': '3',
        'title': 'Dinner at Restaurant',
        'amount': 85.25,
        'category': 'Food & Dining',
        'date': '2024-01-20',
        'description': 'Fine dining at Le Bernardin',
      },
    ];
    totalBudget.value = 2000.0;
  }

  void calculateTotals() {
    totalExpenses.value = expenses.fold(0.0, (sum, expense) => sum + (expense['amount'] as double));
  }

  void addExpense(Map<String, dynamic> expense) {
    expenses.add(expense);
    calculateTotals();
    Get.snackbar(
      'Success',
      'Expense added successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void updateBudget(double budget) {
    totalBudget.value = budget;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  List<Map<String, dynamic>> get filteredExpenses {
    if (selectedCategory.value == 'All') {
      return expenses;
    }
    return expenses.where((expense) => expense['category'] == selectedCategory.value).toList();
  }

  double get remainingBudget => totalBudget.value - totalExpenses.value;
  double get budgetPercentage => totalBudget.value > 0 ? (totalExpenses.value / totalBudget.value) : 0.0;

  void deleteExpense(String expenseId) {
    expenses.removeWhere((expense) => expense['id'] == expenseId);
    calculateTotals();
    Get.snackbar(
      'Deleted',
      'Expense deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}