import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeSupabase() async {
  try {
    await dotenv.load(fileName: ".env");
    // await Supabase.initialize(
    //   url: dotenv.env['https://vkdmrqrkkyrrgxkjblzw.supabase.co']!,
    //   anonKey: dotenv.env['eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrZG1ycXJra3lycmd4a2pibHp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE4Njg0NTQsImV4cCI6MjAzNzQ0NDQ1NH0.qLXpCb53YRTBjSclCw7cRUNIskSDvxZIUu2G5jZm00s']!,
    // );
    await Supabase.initialize(
      url: 'https://vkdmrqrkkyrrgxkjblzw.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrZG1ycXJra3lycmd4a2pibHp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE4Njg0NTQsImV4cCI6MjAzNzQ0NDQ1NH0.qLXpCb53YRTBjSclCw7cRUNIskSDvxZIUu2G5jZm00s',
    );
    print('Supabase initialized successfully');
  } catch (e) {
    print('Failed to initialize Supabase: $e');
    rethrow;
  }
}
