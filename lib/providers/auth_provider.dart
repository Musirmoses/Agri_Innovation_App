import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../services/supabase_service.dart';

class AuthProvider extends ChangeNotifier {
  final _db = SupabaseService().client;

  UserProfile? user;
  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _db.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        isLoading = false;
        notifyListeners();
        return false;
      }

      await loadUserProfile();
      return true;
    } catch (e) {
      debugPrint("Login error: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String email, String password, String name) async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await _db.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user == null) return false;

      await _db.from('users').insert({
        'auth_id': res.user!.id,
        'name': name,
        'created_at': DateTime.now().toIso8601String(),
      });

      await loadUserProfile();
      return true;
    } catch (e) {
      debugPrint("Register error: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserProfile() async {
    final authId = _db.auth.currentUser?.id;
    if (authId == null) return;

    final data =
        await _db.from("users").select().eq("auth_id", authId).maybeSingle();

    if (data != null) {
      user = UserProfile.fromMap(data);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _db.auth.signOut();
    user = null;
    notifyListeners();
  }
}
