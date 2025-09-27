import '../models/destination.dart';
import '../models/travel_package.dart';

class DummyData {
  static List<Destination> get destinations => [
        Destination(
          id: '1',
          name: 'Santorini',
          description:
              'A stunning Greek island known for its white buildings, blue domes, and spectacular sunsets over the Aegean Sea.',
          imageUrl:
              'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
            'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800',
            'https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e?w=800',
          ],
          country: 'Greece',
          city: 'Santorini',
          rating: 4.8,
          reviewsCount: 2847,
          price: 299,
          tags: ['Romantic', 'Sunset', 'Island', 'Photography'],
          activities: ['Wine Tasting', 'Sailing', 'Photography', 'Museums'],
          location: {
            'lat': 36.3932,
            'lng': 25.4615,
          },
          weather: '25°C Sunny',
          bestTimeToVisit: 'April to October',
          isFavorite: true,
        ),
        Destination(
          id: '2',
          name: 'Kyoto',
          description:
              'Ancient capital of Japan, famous for its classical Buddhist temples, gardens, imperial palaces, and traditional wooden houses.',
          imageUrl:
              'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
            'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800',
            'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?w=800',
          ],
          country: 'Japan',
          city: 'Kyoto',
          rating: 4.7,
          reviewsCount: 1923,
          price: 389,
          tags: ['Cultural', 'Temples', 'Traditional', 'Gardens'],
          activities: [
            'Temple Visits',
            'Tea Ceremony',
            'Bamboo Forest',
            'Geisha District'
          ],
          location: {
            'lat': 35.0116,
            'lng': 135.7681,
          },
          weather: '22°C Partly Cloudy',
          bestTimeToVisit: 'March to May, September to November',
        ),
        Destination(
          id: '3',
          name: 'Maldives',
          description:
              'A tropical paradise with crystal-clear waters, white sandy beaches, and luxurious overwater bungalows.',
          imageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
            'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800',
            'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800',
          ],
          country: 'Maldives',
          city: 'Male',
          rating: 4.9,
          reviewsCount: 3456,
          price: 899,
          tags: ['Luxury', 'Beach', 'Diving', 'Honeymoon'],
          activities: ['Snorkeling', 'Diving', 'Spa', 'Water Sports'],
          location: {
            'lat': 3.2028,
            'lng': 73.2207,
          },
          weather: '28°C Tropical',
          bestTimeToVisit: 'November to April',
        ),
        Destination(
          id: '4',
          name: 'Iceland',
          description:
              'Land of fire and ice, featuring dramatic landscapes with waterfalls, geysers, and the Northern Lights.',
          imageUrl:
              'https://images.unsplash.com/photo-1539650116574-75c0c6d73d1e?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1539650116574-75c0c6d73d1e?w=800',
            'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800',
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
          ],
          country: 'Iceland',
          city: 'Reykjavik',
          rating: 4.6,
          reviewsCount: 2156,
          price: 599,
          tags: ['Adventure', 'Northern Lights', 'Nature', 'Photography'],
          activities: [
            'Northern Lights',
            'Golden Circle',
            'Blue Lagoon',
            'Glacier Hiking'
          ],
          location: {
            'lat': 64.1466,
            'lng': -21.9426,
          },
          weather: '8°C Cool',
          bestTimeToVisit:
              'September to March (Northern Lights), June to August (Midnight Sun)',
        ),
        Destination(
          id: '5',
          name: 'Bali',
          description:
              'Indonesian paradise known for its lush rice terraces, ancient temples, and vibrant cultural scene.',
          imageUrl:
              'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=800',
            'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=800',
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800',
          ],
          country: 'Indonesia',
          city: 'Ubud',
          rating: 4.5,
          reviewsCount: 4234,
          price: 199,
          tags: ['Tropical', 'Temples', 'Rice Terraces', 'Wellness'],
          activities: [
            'Temple Tours',
            'Yoga Retreats',
            'Rice Terrace Walks',
            'Cooking Classes'
          ],
          location: {
            'lat': -8.5069,
            'lng': 115.2625,
          },
          weather: '26°C Humid',
          bestTimeToVisit: 'April to October',
        ),
        Destination(
          id: '6',
          name: 'Machu Picchu',
          description:
              'Ancient Incan citadel set high in the Andes Mountains, one of the New Seven Wonders of the World.',
          imageUrl:
              'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800',
            'https://images.unsplash.com/photo-1531065208531-4036c0dba3ca?w=800',
            'https://images.unsplash.com/photo-1526392060635-9d6019884377?w=800',
          ],
          country: 'Peru',
          city: 'Cusco',
          rating: 4.8,
          reviewsCount: 5678,
          price: 449,
          tags: ['Historical', 'Adventure', 'Hiking', 'Ancient'],
          activities: [
            'Inca Trail',
            'Sacred Valley',
            'Llama Encounters',
            'Archaeological Tours'
          ],
          location: {
            'lat': -13.1631,
            'lng': -72.5450,
          },
          weather: '15°C Mountain Climate',
          bestTimeToVisit: 'May to September',
        ),
      ];

  static List<TravelPackage> get travelPackages => [
        TravelPackage(
          id: '1',
          title: 'Greek Island Hopping Adventure',
          description:
              'Explore the most beautiful Greek islands including Santorini, Mykonos, and Crete in this 10-day adventure.',
          imageUrl:
              'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
            'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800',
            'https://images.unsplash.com/photo-1613395877344-13d4a8e0d49e?w=800',
          ],
          price: 1299,
          duration: 10,
          durationType: 'days',
          destinations: ['Santorini', 'Mykonos', 'Crete'],
          includes: [
            'Accommodation in 4-star hotels',
            'All transfers',
            'Ferry tickets between islands',
            'Professional guide',
            'Breakfast daily',
          ],
          excludes: [
            'International flights',
            'Lunch and dinner',
            'Personal expenses',
            'Travel insurance',
          ],
          rating: 4.8,
          reviewsCount: 342,
          difficulty: 'Easy',
          packageType: 'Island Hopping',
          isPopular: true,
          isFeatured: true,
          itinerary: {
            'day1': 'Arrival in Athens, transfer to Santorini',
            'day2-4':
                'Explore Santorini - Oia sunset, wine tasting, volcanic tour',
            'day5-7': 'Mykonos - beaches, nightlife, archaeological sites',
            'day8-10': 'Crete - Knossos Palace, Chania old town, departure',
          },
        ),
        TravelPackage(
          id: '2',
          title: 'Japan Cultural Experience',
          description:
              'Immerse yourself in Japanese culture with visits to Tokyo, Kyoto, and Mount Fuji.',
          imageUrl:
              'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
            'https://images.unsplash.com/photo-1528164344705-47542687000d?w=800',
            'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?w=800',
          ],
          price: 1899,
          duration: 14,
          durationType: 'days',
          destinations: ['Tokyo', 'Kyoto', 'Mount Fuji'],
          includes: [
            'Ryokan accommodation',
            'JR Rail Pass',
            'Cultural experiences',
            'English-speaking guide',
            'Traditional meals',
          ],
          excludes: [
            'International flights',
            'Personal shopping',
            'Extra activities',
            'Travel insurance',
          ],
          rating: 4.9,
          reviewsCount: 567,
          difficulty: 'Moderate',
          packageType: 'Cultural',
          isPopular: true,
          isFeatured: false,
          itinerary: {
            'day1-5': 'Tokyo exploration - temples, markets, modern districts',
            'day6-10':
                'Kyoto cultural immersion - traditional temples, tea ceremony',
            'day11-14': 'Mount Fuji region - hiking, hot springs, departure',
          },
        ),
        TravelPackage(
          id: '3',
          title: 'Maldives Luxury Escape',
          description:
              'Ultimate luxury experience with overwater villas, private beaches, and world-class diving.',
          imageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
          gallery: [
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
            'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800',
            'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800',
          ],
          price: 3499,
          duration: 7,
          durationType: 'days',
          destinations: ['Male', 'Private Resort Island'],
          includes: [
            'Overwater villa accommodation',
            'All meals and beverages',
            'Spa treatments',
            'Water sports equipment',
            'Private transfers',
          ],
          excludes: [
            'International flights',
            'Extra spa services',
            'Excursions',
            'Travel insurance',
          ],
          rating: 4.9,
          reviewsCount: 234,
          difficulty: 'Relaxing',
          packageType: 'Luxury',
          isPopular: true,
          isFeatured: true,
          itinerary: {
            'day1': 'Arrival and resort orientation',
            'day2-6': 'Beach relaxation, water activities, spa treatments',
            'day7': 'Departure',
          },
        ),
      ];

  static List<String> get categories => [
        'All',
        'Beach',
        'Mountains',
        'Cities',
        'Cultural',
        'Adventure',
        'Luxury',
        'Budget',
      ];

  static List<Map<String, dynamic>> get features => [
        {
          'icon': '🌍',
          'title': 'Destination Explorer',
          'description': 'Discover amazing places worldwide',
        },
        {
          'icon': '📱',
          'title': 'Smart Itinerary',
          'description': 'AI-powered trip planning',
        },
        {
          'icon': '🎯',
          'title': 'AR City Guide',
          'description': 'Augmented reality exploration',
        },
        {
          'icon': '💰',
          'title': 'Best Deals',
          'description': 'Compare prices and save money',
        },
      ];

  static List<Map<String, dynamic>> get reviews => [
        {
          'userName': 'Sarah Johnson',
          'userImage':
              'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
          'rating': 5.0,
          'comment':
              'Amazing experience! The app made planning my trip so easy.',
          'date': '2024-01-15',
          'destination': 'Santorini',
        },
        {
          'userName': 'Mike Chen',
          'userImage':
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
          'rating': 4.8,
          'comment': 'Great recommendations and beautiful UI design.',
          'date': '2024-01-10',
          'destination': 'Tokyo',
        },
        {
          'userName': 'Emily Davis',
          'userImage':
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
          'rating': 4.9,
          'comment':
              'The AR features are incredible! Made exploring so much fun.',
          'date': '2024-01-08',
          'destination': 'Bali',
        },
      ];
}
