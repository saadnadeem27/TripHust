import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL_HERE';
  static const String supabaseKey = 'YOUR_SUPABASE_ANON_KEY_HERE';
  
  static SupabaseClient get client => Supabase.instance.client;
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }
  
  // Database Tables
  static const String usersTable = 'users';
  static const String destinationsTable = 'destinations';
  static const String bookingsTable = 'bookings';
  static const String journalEntriesTable = 'journal_entries';
  static const String expensesTable = 'expenses';
  static const String itinerariesTable = 'itineraries';
  static const String packagesTable = 'packages';
  static const String reviewsTable = 'reviews';
  static const String favoritesTable = 'favorites';
  
  // Storage Buckets
  static const String profileImagesBucket = 'profile-images';
  static const String journalImagesBucket = 'journal-images';
  static const String destinationImagesBucket = 'destination-images';
}

// SQL Table Creation Queries
class SupabaseTables {
  
  // Users Table
  static const String createUsersTable = '''
    CREATE TABLE users (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      email VARCHAR UNIQUE NOT NULL,
      name VARCHAR NOT NULL,
      avatar_url VARCHAR,
      phone VARCHAR,
      date_of_birth DATE,
      bio TEXT,
      country VARCHAR,
      preferred_currency VARCHAR DEFAULT 'USD',
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- RLS Policies
    ALTER TABLE users ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Users can view own profile" ON users FOR SELECT USING (auth.uid() = id);
    CREATE POLICY "Users can update own profile" ON users FOR UPDATE USING (auth.uid() = id);
  ''';
  
  // Destinations Table
  static const String createDestinationsTable = '''
    CREATE TABLE destinations (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      name VARCHAR NOT NULL,
      city VARCHAR NOT NULL,
      country VARCHAR NOT NULL,
      description TEXT NOT NULL,
      image_url VARCHAR NOT NULL,
      gallery JSONB DEFAULT '[]',
      price DECIMAL(10,2) NOT NULL,
      rating DECIMAL(2,1) DEFAULT 0.0,
      reviews_count INTEGER DEFAULT 0,
      tags TEXT[] DEFAULT '{}',
      activities TEXT[] DEFAULT '{}',
      best_time_to_visit VARCHAR,
      weather VARCHAR,
      latitude DECIMAL(10,8),
      longitude DECIMAL(11,8),
      is_featured BOOLEAN DEFAULT FALSE,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- Indexes
    CREATE INDEX idx_destinations_country ON destinations(country);
    CREATE INDEX idx_destinations_featured ON destinations(is_featured);
    CREATE INDEX idx_destinations_rating ON destinations(rating DESC);
    
    -- RLS Policies
    ALTER TABLE destinations ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Destinations are publicly readable" ON destinations FOR SELECT USING (true);
  ''';
  
  // Bookings Table
  static const String createBookingsTable = '''
    CREATE TABLE bookings (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      user_id UUID REFERENCES users(id) ON DELETE CASCADE,
      destination_id UUID REFERENCES destinations(id) ON DELETE CASCADE,
      package_id UUID REFERENCES packages(id) ON DELETE CASCADE,
      booking_date DATE NOT NULL,
      check_in_date DATE NOT NULL,
      check_out_date DATE NOT NULL,
      guests INTEGER NOT NULL DEFAULT 1,
      total_amount DECIMAL(10,2) NOT NULL,
      status VARCHAR NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),
      payment_status VARCHAR NOT NULL DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'refunded')),
      special_requests TEXT,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- Indexes
    CREATE INDEX idx_bookings_user_id ON bookings(user_id);
    CREATE INDEX idx_bookings_destination_id ON bookings(destination_id);
    CREATE INDEX idx_bookings_status ON bookings(status);
    
    -- RLS Policies
    ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Users can view own bookings" ON bookings FOR SELECT USING (auth.uid() = user_id);
    CREATE POLICY "Users can create own bookings" ON bookings FOR INSERT WITH CHECK (auth.uid() = user_id);
    CREATE POLICY "Users can update own bookings" ON bookings FOR UPDATE USING (auth.uid() = user_id);
  ''';
  
  // Journal Entries Table
  static const String createJournalEntriesTable = '''
    CREATE TABLE journal_entries (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      user_id UUID REFERENCES users(id) ON DELETE CASCADE,
      title VARCHAR NOT NULL,
      content TEXT NOT NULL,
      location VARCHAR,
      latitude DECIMAL(10,8),
      longitude DECIMAL(11,8),
      images JSONB DEFAULT '[]',
      tags TEXT[] DEFAULT '{}',
      category VARCHAR DEFAULT 'general',
      mood VARCHAR,
      weather VARCHAR,
      rating INTEGER CHECK (rating >= 1 AND rating <= 5),
      is_favorite BOOLEAN DEFAULT FALSE,
      is_public BOOLEAN DEFAULT FALSE,
      travel_date DATE,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- Indexes
    CREATE INDEX idx_journal_entries_user_id ON journal_entries(user_id);
    CREATE INDEX idx_journal_entries_category ON journal_entries(category);
    CREATE INDEX idx_journal_entries_travel_date ON journal_entries(travel_date DESC);
    
    -- RLS Policies
    ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Users can view own journal entries" ON journal_entries FOR SELECT USING (auth.uid() = user_id);
    CREATE POLICY "Users can view public journal entries" ON journal_entries FOR SELECT USING (is_public = true);
    CREATE POLICY "Users can create own journal entries" ON journal_entries FOR INSERT WITH CHECK (auth.uid() = user_id);
    CREATE POLICY "Users can update own journal entries" ON journal_entries FOR UPDATE USING (auth.uid() = user_id);
    CREATE POLICY "Users can delete own journal entries" ON journal_entries FOR DELETE USING (auth.uid() = user_id);
  ''';
  
  // Expenses Table
  static const String createExpensesTable = '''
    CREATE TABLE expenses (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      user_id UUID REFERENCES users(id) ON DELETE CASCADE,
      trip_id UUID, -- Reference to a trip/itinerary
      title VARCHAR NOT NULL,
      amount DECIMAL(10,2) NOT NULL,
      currency VARCHAR NOT NULL DEFAULT 'USD',
      category VARCHAR NOT NULL,
      description TEXT,
      receipt_url VARCHAR,
      expense_date DATE NOT NULL,
      location VARCHAR,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- Indexes
    CREATE INDEX idx_expenses_user_id ON expenses(user_id);
    CREATE INDEX idx_expenses_trip_id ON expenses(trip_id);
    CREATE INDEX idx_expenses_category ON expenses(category);
    CREATE INDEX idx_expenses_date ON expenses(expense_date DESC);
    
    -- RLS Policies
    ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Users can view own expenses" ON expenses FOR SELECT USING (auth.uid() = user_id);
    CREATE POLICY "Users can create own expenses" ON expenses FOR INSERT WITH CHECK (auth.uid() = user_id);
    CREATE POLICY "Users can update own expenses" ON expenses FOR UPDATE USING (auth.uid() = user_id);
    CREATE POLICY "Users can delete own expenses" ON expenses FOR DELETE USING (auth.uid() = user_id);
  ''';
  
  // Itineraries Table
  static const String createItinerariesTable = '''
    CREATE TABLE itineraries (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      user_id UUID REFERENCES users(id) ON DELETE CASCADE,
      title VARCHAR NOT NULL,
      description TEXT,
      start_date DATE NOT NULL,
      end_date DATE NOT NULL,
      destinations JSONB DEFAULT '[]', -- Array of destination objects
      activities JSONB DEFAULT '[]', -- Array of activity objects
      budget DECIMAL(10,2),
      total_expenses DECIMAL(10,2) DEFAULT 0.0,
      status VARCHAR NOT NULL DEFAULT 'planning' CHECK (status IN ('planning', 'active', 'completed', 'cancelled')),
      is_public BOOLEAN DEFAULT FALSE,
      cover_image_url VARCHAR,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- Indexes
    CREATE INDEX idx_itineraries_user_id ON itineraries(user_id);
    CREATE INDEX idx_itineraries_status ON itineraries(status);
    CREATE INDEX idx_itineraries_start_date ON itineraries(start_date DESC);
    
    -- RLS Policies
    ALTER TABLE itineraries ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Users can view own itineraries" ON itineraries FOR SELECT USING (auth.uid() = user_id);
    CREATE POLICY "Users can view public itineraries" ON itineraries FOR SELECT USING (is_public = true);
    CREATE POLICY "Users can create own itineraries" ON itineraries FOR INSERT WITH CHECK (auth.uid() = user_id);
    CREATE POLICY "Users can update own itineraries" ON itineraries FOR UPDATE USING (auth.uid() = user_id);
    CREATE POLICY "Users can delete own itineraries" ON itineraries FOR DELETE USING (auth.uid() = user_id);
  ''';
  
  // Packages Table
  static const String createPackagesTable = '''
    CREATE TABLE packages (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      title VARCHAR NOT NULL,
      description TEXT NOT NULL,
      destination_ids UUID[] DEFAULT '{}', -- Array of destination IDs
      duration_days INTEGER NOT NULL,
      price DECIMAL(10,2) NOT NULL,
      original_price DECIMAL(10,2),
      includes TEXT[] DEFAULT '{}',
      excludes TEXT[] DEFAULT '{}',
      highlights TEXT[] DEFAULT '{}',
      image_url VARCHAR NOT NULL,
      gallery JSONB DEFAULT '[]',
      rating DECIMAL(2,1) DEFAULT 0.0,
      reviews_count INTEGER DEFAULT 0,
      max_travelers INTEGER,
      difficulty_level VARCHAR DEFAULT 'easy' CHECK (difficulty_level IN ('easy', 'moderate', 'challenging')),
      category VARCHAR NOT NULL,
      is_featured BOOLEAN DEFAULT FALSE,
      available_from DATE,
      available_to DATE,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    
    -- Indexes
    CREATE INDEX idx_packages_category ON packages(category);
    CREATE INDEX idx_packages_featured ON packages(is_featured);
    CREATE INDEX idx_packages_price ON packages(price ASC);
    CREATE INDEX idx_packages_rating ON packages(rating DESC);
    
    -- RLS Policies
    ALTER TABLE packages ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Packages are publicly readable" ON packages FOR SELECT USING (true);
  ''';
  
  // Reviews Table
  static const String createReviewsTable = '''
    CREATE TABLE reviews (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      user_id UUID REFERENCES users(id) ON DELETE CASCADE,
      destination_id UUID REFERENCES destinations(id) ON DELETE CASCADE,
      package_id UUID REFERENCES packages(id) ON DELETE CASCADE,
      booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
      rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
      title VARCHAR NOT NULL,
      content TEXT NOT NULL,
      images JSONB DEFAULT '[]',
      helpful_count INTEGER DEFAULT 0,
      is_verified BOOLEAN DEFAULT FALSE, -- Verified purchase/booking
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      
      -- Ensure one review per user per item
      UNIQUE(user_id, destination_id),
      UNIQUE(user_id, package_id),
      UNIQUE(user_id, booking_id)
    );
    
    -- Indexes
    CREATE INDEX idx_reviews_destination_id ON reviews(destination_id);
    CREATE INDEX idx_reviews_package_id ON reviews(package_id);
    CREATE INDEX idx_reviews_user_id ON reviews(user_id);
    CREATE INDEX idx_reviews_rating ON reviews(rating DESC);
    
    -- RLS Policies
    ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Reviews are publicly readable" ON reviews FOR SELECT USING (true);
    CREATE POLICY "Users can create own reviews" ON reviews FOR INSERT WITH CHECK (auth.uid() = user_id);
    CREATE POLICY "Users can update own reviews" ON reviews FOR UPDATE USING (auth.uid() = user_id);
    CREATE POLICY "Users can delete own reviews" ON reviews FOR DELETE USING (auth.uid() = user_id);
  ''';
  
  // Favorites Table
  static const String createFavoritesTable = '''
    CREATE TABLE favorites (
      id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
      user_id UUID REFERENCES users(id) ON DELETE CASCADE,
      destination_id UUID REFERENCES destinations(id) ON DELETE CASCADE,
      package_id UUID REFERENCES packages(id) ON DELETE CASCADE,
      journal_entry_id UUID REFERENCES journal_entries(id) ON DELETE CASCADE,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
      
      -- Ensure unique favorites
      UNIQUE(user_id, destination_id),
      UNIQUE(user_id, package_id),
      UNIQUE(user_id, journal_entry_id)
    );
    
    -- Indexes
    CREATE INDEX idx_favorites_user_id ON favorites(user_id);
    CREATE INDEX idx_favorites_destination_id ON favorites(destination_id);
    CREATE INDEX idx_favorites_package_id ON favorites(package_id);
    
    -- RLS Policies
    ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;
    CREATE POLICY "Users can view own favorites" ON favorites FOR SELECT USING (auth.uid() = user_id);
    CREATE POLICY "Users can create own favorites" ON favorites FOR INSERT WITH CHECK (auth.uid() = user_id);
    CREATE POLICY "Users can delete own favorites" ON favorites FOR DELETE USING (auth.uid() = user_id);
  ''';
  
  // Create all tables at once
  static const String createAllTables = '''
    $createUsersTable
    $createDestinationsTable
    $createPackagesTable
    $createBookingsTable
    $createJournalEntriesTable
    $createExpensesTable
    $createItinerariesTable
    $createReviewsTable
    $createFavoritesTable
  ''';
}