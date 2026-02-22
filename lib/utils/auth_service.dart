import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabaseClient.auth.signUp(
        email: email,
        password: password);
  }

  // Sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // Get user email
  User? getCurrentUserInfo() {
    final session = _supabaseClient.auth.currentSession;
    return session?.user;
  }
}
