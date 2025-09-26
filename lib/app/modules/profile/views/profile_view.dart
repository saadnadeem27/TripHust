import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widgets/glassmorphic_widgets_new.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(),
                _buildStatsSection(),
                _buildMembershipSection(),
                _buildQuickActions(),
                _buildRecentActivity(),
                _buildSettingsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GlassmorphicContainer(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: controller.openSettings,
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          GlassmorphicCard(
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(() => CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: controller.profileImage.value.isNotEmpty
                              ? CachedNetworkImageProvider(controller.profileImage.value)
                              : null,
                          child: controller.profileImage.value.isEmpty
                              ? const Icon(Icons.person, size: 50, color: Colors.white54)
                              : null,
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.changeProfilePicture,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(() => Text(
                      controller.userName.value,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(height: 4),
                Obx(() => Text(
                      controller.userEmail.value,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    )),
                const SizedBox(height: 8),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white54, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          controller.userLocation.value,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                GradientButton(
                  text: 'Edit Profile',
                  onPressed: controller.editProfile,
                  height: 45,
                  icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Trips',
              controller.totalTrips.value.toString(),
              Icons.flight_takeoff,
              AppTheme.primaryGradient,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Countries',
              controller.totalCountries.value.toString(),
              Icons.public,
              AppTheme.secondaryGradient,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Cities',
              controller.totalCities.value.toString(),
              Icons.location_city,
              AppTheme.cardGradient,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Photos',
              controller.totalPhotos.value.toString(),
              Icons.photo_camera,
              AppTheme.backgroundGradient,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Gradient gradient) {
    return GlassmorphicCard(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassmorphicCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.diamond, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Obx(() => Text(
                            controller.membershipType.value,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                Obx(() => Text(
                      'Expires ${controller.membershipExpiry.value}',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Loyalty Points',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.stars, color: Colors.amber, size: 24),
                const SizedBox(width: 8),
                Obx(() => Text(
                      '${controller.loyaltyPoints.value} Points',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.7, // 70% progress
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '550 points to next reward',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Travel History',
                  Icons.history,
                  AppTheme.primaryGradient,
                  controller.viewTravelHistory,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'My Bookings',
                  Icons.bookmark,
                  AppTheme.secondaryGradient,
                  controller.manageBookings,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Favorites',
                  Icons.favorite,
                  AppTheme.cardGradient,
                  controller.viewFavorites,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Support',
                  Icons.support_agent,
                  AppTheme.backgroundGradient,
                  controller.contactSupport,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Gradient gradient, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphicCard(
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Column(
                children: controller.recentActivities.map((activity) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: GlassmorphicCard(
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: _getActivityGradient(activity['type']),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              _getActivityIcon(activity['icon']),
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity['title'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  activity['date'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          GlassmorphicCard(
            child: Column(
              children: [
                _buildSettingsItem(
                  'Notifications',
                  Icons.notifications,
                  trailing: Obx(() => Switch(
                        value: controller.notificationsEnabled.value,
                        onChanged: (_) => controller.toggleNotifications(),
                        activeColor: AppTheme.primaryColor,
                      )),
                ),
                _buildDivider(),
                _buildSettingsItem(
                  'Location Services',
                  Icons.location_on,
                  trailing: Obx(() => Switch(
                        value: controller.locationEnabled.value,
                        onChanged: (_) => controller.toggleLocation(),
                        activeColor: AppTheme.primaryColor,
                      )),
                ),
                _buildDivider(),
                _buildSettingsItem(
                  'Currency',
                  Icons.attach_money,
                  subtitle: controller.currency.value,
                  onTap: controller.changeCurrency,
                ),
                _buildDivider(),
                _buildSettingsItem(
                  'Language',
                  Icons.language,
                  subtitle: controller.language.value,
                  onTap: controller.changeLanguage,
                ),
                _buildDivider(),
                _buildSettingsItem(
                  'Share App',
                  Icons.share,
                  onTap: controller.shareApp,
                ),
                _buildDivider(),
                _buildSettingsItem(
                  'Rate App',
                  Icons.star_rate,
                  onTap: controller.rateApp,
                ),
                _buildDivider(),
                _buildSettingsItem(
                  'Logout',
                  Icons.logout,
                  onTap: controller.logout,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon, {
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Colors.white54,
                fontSize: 14,
              ),
            )
          : null,
      trailing: trailing ??
          (onTap != null
              ? const Icon(Icons.chevron_right, color: Colors.white54)
              : null),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.1),
      height: 1,
    );
  }

  Gradient _getActivityGradient(String type) {
    switch (type) {
      case 'booking':
        return AppTheme.primaryGradient;
      case 'review':
        return AppTheme.secondaryGradient;
      case 'photo':
        return AppTheme.cardGradient;
      case 'achievement':
        return AppTheme.backgroundGradient;
      default:
        return AppTheme.primaryGradient;
    }
  }

  IconData _getActivityIcon(String iconName) {
    switch (iconName) {
      case 'flight_takeoff':
        return Icons.flight_takeoff;
      case 'star':
        return Icons.star;
      case 'photo_camera':
        return Icons.photo_camera;
      case 'emoji_events':
        return Icons.emoji_events;
      default:
        return Icons.circle;
    }
  }
}
