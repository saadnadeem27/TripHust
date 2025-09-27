class TravelPackage {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> gallery;
  final double price;
  final String currency;
  final int duration;
  final String durationType; // days, weeks, months
  final List<String> destinations;
  final List<String> includes;
  final List<String> excludes;
  final double rating;
  final int reviewsCount;
  final String difficulty;
  final String packageType;
  final bool isPopular;
  final bool isFeatured;
  final Map<String, dynamic> itinerary;

  TravelPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.gallery,
    required this.price,
    this.currency = 'USD',
    required this.duration,
    this.durationType = 'days',
    required this.destinations,
    required this.includes,
    required this.excludes,
    required this.rating,
    required this.reviewsCount,
    required this.difficulty,
    required this.packageType,
    this.isPopular = false,
    this.isFeatured = false,
    required this.itinerary,
  });

  factory TravelPackage.fromJson(Map<String, dynamic> json) {
    return TravelPackage(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      gallery: List<String>.from(json['gallery']),
      price: json['price'].toDouble(),
      currency: json['currency'] ?? 'USD',
      duration: json['duration'],
      durationType: json['durationType'] ?? 'days',
      destinations: List<String>.from(json['destinations']),
      includes: List<String>.from(json['includes']),
      excludes: List<String>.from(json['excludes']),
      rating: json['rating'].toDouble(),
      reviewsCount: json['reviewsCount'],
      difficulty: json['difficulty'],
      packageType: json['packageType'],
      isPopular: json['isPopular'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      itinerary: json['itinerary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'gallery': gallery,
      'price': price,
      'currency': currency,
      'duration': duration,
      'durationType': durationType,
      'destinations': destinations,
      'includes': includes,
      'excludes': excludes,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'difficulty': difficulty,
      'packageType': packageType,
      'isPopular': isPopular,
      'isFeatured': isFeatured,
      'itinerary': itinerary,
    };
  }
}
