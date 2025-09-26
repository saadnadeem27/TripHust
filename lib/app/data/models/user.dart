class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImage;
  final String? bio;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final List<String> favoriteDestinations;
  final List<String> visitedCountries;
  final int tripPoints;
  final String membershipLevel;
  final Map<String, dynamic> preferences;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImage,
    this.bio,
    required this.createdAt,
    this.lastLoginAt,
    required this.favoriteDestinations,
    required this.visitedCountries,
    this.tripPoints = 0,
    this.membershipLevel = 'Explorer',
    required this.preferences,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      bio: json['bio'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
      favoriteDestinations: List<String>.from(json['favoriteDestinations']),
      visitedCountries: List<String>.from(json['visitedCountries']),
      tripPoints: json['tripPoints'] ?? 0,
      membershipLevel: json['membershipLevel'] ?? 'Explorer',
      preferences: json['preferences'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'favoriteDestinations': favoriteDestinations,
      'visitedCountries': visitedCountries,
      'tripPoints': tripPoints,
      'membershipLevel': membershipLevel,
      'preferences': preferences,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImage,
    String? bio,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    List<String>? favoriteDestinations,
    List<String>? visitedCountries,
    int? tripPoints,
    String? membershipLevel,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      favoriteDestinations: favoriteDestinations ?? this.favoriteDestinations,
      visitedCountries: visitedCountries ?? this.visitedCountries,
      tripPoints: tripPoints ?? this.tripPoints,
      membershipLevel: membershipLevel ?? this.membershipLevel,
      preferences: preferences ?? this.preferences,
    );
  }
}