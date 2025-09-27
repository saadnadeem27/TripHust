class Destination {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> gallery;
  final String country;
  final String city;
  final double rating;
  final int reviewsCount;
  final double price;
  final String currency;
  final List<String> tags;
  final List<String> activities;
  final Map<String, dynamic> location;
  final String weather;
  final String bestTimeToVisit;
  final bool isFavorite;

  Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.gallery,
    required this.country,
    required this.city,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    this.currency = 'USD',
    required this.tags,
    required this.activities,
    required this.location,
    required this.weather,
    required this.bestTimeToVisit,
    this.isFavorite = false,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      gallery: List<String>.from(json['gallery']),
      country: json['country'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      reviewsCount: json['reviewsCount'],
      price: json['price'].toDouble(),
      currency: json['currency'] ?? 'USD',
      tags: List<String>.from(json['tags']),
      activities: List<String>.from(json['activities']),
      location: json['location'],
      weather: json['weather'],
      bestTimeToVisit: json['bestTimeToVisit'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'gallery': gallery,
      'country': country,
      'city': city,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'price': price,
      'currency': currency,
      'tags': tags,
      'activities': activities,
      'location': location,
      'weather': weather,
      'bestTimeToVisit': bestTimeToVisit,
      'isFavorite': isFavorite,
    };
  }

  Destination copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? gallery,
    String? country,
    String? city,
    double? rating,
    int? reviewsCount,
    double? price,
    String? currency,
    List<String>? tags,
    List<String>? activities,
    Map<String, dynamic>? location,
    String? weather,
    String? bestTimeToVisit,
    bool? isFavorite,
  }) {
    return Destination(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      gallery: gallery ?? this.gallery,
      country: country ?? this.country,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      tags: tags ?? this.tags,
      activities: activities ?? this.activities,
      location: location ?? this.location,
      weather: weather ?? this.weather,
      bestTimeToVisit: bestTimeToVisit ?? this.bestTimeToVisit,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
