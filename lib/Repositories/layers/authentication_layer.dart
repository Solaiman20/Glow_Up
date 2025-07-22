import 'dart:developer';

import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/profile.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationLayer {
  final supaConnect = SupabaseConnect();
  final SupabaseClient _client = Supabase.instance.client;
  Profile? userProfile;
  User? user;
  Provider? theProvider;

  Future<bool> signUpUser({
    required String email,
    required String password,
    required String username,
    required LatLng position,
  }) async {
    try {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      final User? user = response.user; // Why this ???
      userProfile = Profile(
        id: user!.id,
        username: username,
        fullName: "",
        role: "customer",
        latitude: position.latitude,
        longitude: position.longitude,
        phone: null,
      );
    } on Exception catch (e) {
      log("Sign Up Error $e");
      return false;
    }
    try {
      _client.from("profiles").upsert(userProfile!.toJson());
      return true;
    } catch (e) {
      log("Error creating user profile: $e");
      return false;
    }
  }

  Future<bool> signUpProvider({
    required String email,
    required String password,
    required String number,
    required String username,
    required String address,
    required LatLng position,
  }) async {
    try {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      final User? user = response.user; // Why this ???
      userProfile = Profile(
        id: user!.id,
        fullName: "",
        role: "provider",
        phone: number,
        username: username,
      );
      final provider = Provider(
        name: username,
        createdAt: DateTime.now().toIso8601String(),
        id: user!.id,
        phone: number,
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
        avgRating: null,
        ratingCount: 0,
      );

      await _client.from("profiles").upsert(userProfile!.toJson());
      await _client.from("proivders").upsert(provider.toJson());
      return true;
    } catch (e) {
      log("Error signing up provider: $e");
      return false;
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final AuthResponse response = await _client.auth.signInWithPassword(
      password: password,
    );
    final Session? session = response.session;
    final User? resUser = response.user;
    user = resUser;

    final userProfileResponse = await _client
        .from("profiles")
        .select("*")
        .eq("id", user!.id)
        .single();
    userProfile = Profile.fromJson(userProfileResponse);

    if (userProfile!.role == "customer") {
      await supaConnect.getDistancesFromUser();
      supaConnect.linkData();
    } else if (userProfile!.role == "provider") {
      final providerProfileResponse = await _client
          .from("providers")
          .select("*")
          .eq("id", user!.id)
          .single();
      theProvider = Provider.fromJson(providerProfileResponse);
      supaConnect.linkData();
    }
    if (session != null) {
      log(
        "User signed in: ${user!.email}",
      ); // Need to be checked for NULL Condition
      return true;
    } else {
      log("Sign in failed");
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _client.auth.signOut();
      user = null;
      userProfile = null;
      theProvider = null;
      log("User signed out successfully");
      return true;
    } catch (e) {
      log("Error signing out: $e");
      return false;
    }
  }
}
