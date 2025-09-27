import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/glassmorphic_widgets_new.dart';
import '../controllers/ar_guide_controller.dart';

class ARGuideView extends GetView<ARGuideController> {
  const ARGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnimatedGradientBackground(
        colors: const [
          Color(0xFF0A0A0A),
          Color(0xFF1A1A2E),
          Color(0xFF16213E),
        ],
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverToBoxAdapter(
                child: _buildCustomAppBar(),
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: _buildHeroSection(),
              ),

              // Features Section
              SliverToBoxAdapter(
                child: _buildFeaturesSection(),
              ),

              // Popular Locations
              SliverToBoxAdapter(
                child: _buildPopularLocations(),
              ),

              // AR Tools
              SliverToBoxAdapter(
                child: _buildARTools(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildStartARButton(),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.view_in_ar,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'AR City Guide',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassmorphicCard(
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.view_in_ar,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Augmented Reality City Guide',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Discover cities like never before with AR technology. Point your camera and explore landmarks, restaurants, and hidden gems with interactive overlays.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.location_on,
        'title': 'Live Location Tracking',
        'description': 'Real-time GPS positioning with AR overlay',
        'color': Colors.blue,
      },
      {
        'icon': Icons.camera_alt,
        'title': 'AR Camera View',
        'description': 'Point and discover with augmented reality',
        'color': Colors.green,
      },
      {
        'icon': Icons.info,
        'title': 'Instant Information',
        'description': 'Get details about landmarks and places',
        'color': Colors.orange,
      },
      {
        'icon': Icons.navigation,
        'title': 'AR Navigation',
        'description': 'Follow AR arrows to your destination',
        'color': Colors.purple,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return GlassmorphicCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (feature['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        feature['icon'] as IconData,
                        size: 30,
                        color: feature['color'] as Color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      feature['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // const SizedBox(height: 8),
                    // Text(
                    //   feature['description'] as String,
                    //   style: GoogleFonts.poppins(
                    //     fontSize: 12,
                    //     color: Colors.white70,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPopularLocations() {
    final locations = [
      {
        'name': 'Times Square',
        'city': 'New York',
        'image': 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=400',
        'arFeatures': 12,
      },
      {
        'name': 'Eiffel Tower',
        'city': 'Paris',
        'image': 'https://images.unsplash.com/photo-1543349689-9a4d426bee8e?w=400',
        'arFeatures': 18,
      },
      {
        'name': 'Tokyo Tower',
        'city': 'Tokyo',
        'image': 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
        'arFeatures': 15,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular AR Locations',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  child: GlassmorphicCard(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: AppTheme.primaryGradient,
                              ),
                              child: const Icon(
                                Icons.location_city,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          location['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          location['city'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.view_in_ar,
                              size: 14,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${location['arFeatures']} AR Points',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildARTools() {
    final tools = [
      {
        'icon': Icons.qr_code_scanner,
        'title': 'QR Scanner',
        'description': 'Scan QR codes for instant info',
      },
      {
        'icon': Icons.translate,
        'title': 'AR Translator',
        'description': 'Translate signs in real-time',
      },
      {
        'icon': Icons.directions,
        'title': 'AR Directions',
        'description': 'Follow AR arrows to navigate',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AR Tools',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...tools.map((tool) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: GlassmorphicCard(
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: AppTheme.secondaryGradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          tool['icon'] as IconData,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tool['title'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tool['description'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildStartARButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: controller.startARSession,
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        label: Text(
          'Start AR',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}