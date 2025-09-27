import 'package:get/get.dart';

class CurrencyConverterController extends GetxController {
  final RxString fromCurrency = 'USD'.obs;
  final RxString toCurrency = 'EUR'.obs;
  final RxString amount = '1.0'.obs;
  final RxString convertedAmount = '0.85'.obs;
  final RxBool isLoading = false.obs;
  final RxList<String> recentConversions = <String>[].obs;

  final List<Map<String, String>> currencies = [
    {'code': 'USD', 'name': 'US Dollar', 'flag': '🇺🇸'},
    {'code': 'EUR', 'name': 'Euro', 'flag': '🇪🇺'},
    {'code': 'GBP', 'name': 'British Pound', 'flag': '🇬🇧'},
    {'code': 'JPY', 'name': 'Japanese Yen', 'flag': '🇯🇵'},
    {'code': 'CNY', 'name': 'Chinese Yuan', 'flag': '🇨🇳'},
    {'code': 'AUD', 'name': 'Australian Dollar', 'flag': '🇦🇺'},
    {'code': 'CAD', 'name': 'Canadian Dollar', 'flag': '🇨🇦'},
    {'code': 'CHF', 'name': 'Swiss Franc', 'flag': '🇨🇭'},
    {'code': 'INR', 'name': 'Indian Rupee', 'flag': '🇮🇳'},
    {'code': 'KRW', 'name': 'South Korean Won', 'flag': '🇰🇷'},
  ];

  final Map<String, double> exchangeRates = {
    'USD_EUR': 0.85,
    'USD_GBP': 0.73,
    'USD_JPY': 110.0,
    'USD_CNY': 6.45,
    'USD_AUD': 1.35,
    'USD_CAD': 1.25,
    'USD_CHF': 0.92,
    'USD_INR': 74.5,
    'USD_KRW': 1180.0,
    'EUR_USD': 1.18,
    'EUR_GBP': 0.86,
    'EUR_JPY': 129.0,
    // Add more rates as needed
  };

  @override
  void onInit() {
    super.onInit();
    loadRecentConversions();
    convertCurrency();
  }

  void loadRecentConversions() {
    recentConversions.value = [
      '100 USD → 85 EUR',
      '500 EUR → 590 USD',
      '50 GBP → 68 USD',
    ];
  }

  void convertCurrency() {
    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final inputAmount = double.tryParse(amount.value) ?? 0.0;
      final rateKey = '${fromCurrency.value}_${toCurrency.value}';
      final reverseRateKey = '${toCurrency.value}_${fromCurrency.value}';

      double rate = 1.0;
      if (exchangeRates.containsKey(rateKey)) {
        rate = exchangeRates[rateKey]!;
      } else if (exchangeRates.containsKey(reverseRateKey)) {
        rate = 1.0 / exchangeRates[reverseRateKey]!;
      }

      final result = inputAmount * rate;
      convertedAmount.value = result.toStringAsFixed(2);

      // Add to recent conversions
      final conversion =
          '${amount.value} ${fromCurrency.value} → ${convertedAmount.value} ${toCurrency.value}';
      if (!recentConversions.contains(conversion)) {
        recentConversions.insert(0, conversion);
        if (recentConversions.length > 10) {
          recentConversions.removeLast();
        }
      }

      isLoading.value = false;
    });
  }

  void swapCurrencies() {
    final temp = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = temp;
    convertCurrency();
  }

  void updateAmount(String newAmount) {
    amount.value = newAmount;
    if (newAmount.isNotEmpty && double.tryParse(newAmount) != null) {
      convertCurrency();
    }
  }

  void selectFromCurrency(String currency) {
    fromCurrency.value = currency;
    convertCurrency();
  }

  void selectToCurrency(String currency) {
    toCurrency.value = currency;
    convertCurrency();
  }

  void clearRecentConversions() {
    recentConversions.clear();
    Get.snackbar(
      'Cleared',
      'Recent conversions cleared',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String getCurrencyName(String code) {
    final currency = currencies.firstWhere(
      (c) => c['code'] == code,
      orElse: () => {'name': code},
    );
    return currency['name']!;
  }

  String getCurrencyFlag(String code) {
    final currency = currencies.firstWhere(
      (c) => c['code'] == code,
      orElse: () => {'flag': '💱'},
    );
    return currency['flag']!;
  }
}
