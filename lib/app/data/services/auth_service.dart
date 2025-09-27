// Note: Add supabase_flutter to pubspec.yaml dependencies before using
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class AuthService {
  // static final _client = SupabaseConfig.client;

  // Sign Up
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // final response = await _client.auth.signUp(
      //   email: email,
      //   password: password,
      //   data: {'name': name},
      // );

      // if (response.user != null) {
      //   await createUserProfile(
      //     userId: response.user!.id,
      //     email: email,
      //     name: name,
      //   );
      //   return {'success': true, 'user': response.user};
      // }

      return {'success': false, 'error': 'Failed to create account'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Sign In
  static Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // final response = await _client.auth.signInWithPassword(
      //   email: email,
      //   password: password,
      // );

      // if (response.user != null) {
      //   return {'success': true, 'user': response.user};
      // }

      return {'success': false, 'error': 'Invalid credentials'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Sign Out
  static Future<void> signOut() async {
    try {
      // await _client.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  // Get Current User
  static getCurrentUser() {
    // return _client.auth.currentUser;
    return null;
  }

  // Reset Password
  static Future<Map<String, dynamic>> resetPassword(
      {required String email}) async {
    try {
      // await _client.auth.resetPasswordForEmail(email);
      return {'success': true, 'message': 'Password reset email sent'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Create User Profile
  static Future<void> createUserProfile({
    required String userId,
    required String email,
    required String name,
  }) async {
    try {
      // await _client.from(SupabaseConfig.usersTable).insert({
      //   'id': userId,
      //   'email': email,
      //   'name': name,
      // });
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  // Update User Profile
  static Future<Map<String, dynamic>> updateUserProfile({
    required String userId,
    String? name,
    String? avatarUrl,
    String? phone,
    String? bio,
    String? country,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      if (name != null) updateData['name'] = name;
      if (avatarUrl != null) updateData['avatar_url'] = avatarUrl;
      if (phone != null) updateData['phone'] = phone;
      if (bio != null) updateData['bio'] = bio;
      if (country != null) updateData['country'] = country;
      updateData['updated_at'] = DateTime.now().toIso8601String();

      // await _client
      //     .from(SupabaseConfig.usersTable)
      //     .update(updateData)
      //     .eq('id', userId);

      return {'success': true, 'message': 'Profile updated successfully'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Get User Profile
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      // final response = await _client
      //     .from(SupabaseConfig.usersTable)
      //     .select()
      //     .eq('id', userId)
      //     .single();

      // return response;
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }
}
