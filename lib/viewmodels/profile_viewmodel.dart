import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';

class ProfileViewModel extends ChangeNotifier {
  UserProfileModel? _userProfile;
  bool _isLoading = false;

  UserProfileModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  ProfileViewModel() {
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        loadUserProfile(user);
      } else {
        _userProfile = null;
        notifyListeners();
      }
    });
  }

  Future<void> loadUserProfile(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final snapshot = await docRef.get();

      if (snapshot.exists && snapshot.data() != null) {
        _userProfile = UserProfileModel.fromMap(snapshot.data()!, user.uid);
      } else {
        final defaultProfile = UserProfileModel(
          uid: user.uid,
          name: "Dinesh Lakshan",
          email: user.email ?? '',
          phone: "0771234567",
          address: "123 Galle Road, Kalutara, Western Province, Sri Lanka",
        );

        await docRef.set(defaultProfile.toMap());
        _userProfile = defaultProfile;
      }
    } catch (e) {
      debugPrint("Firestore Load Profile Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final updatedData = {
        'name': name.trim(),
        'phone': phone.trim(),
        'address': address.trim(),
      };

      await docRef.set(updatedData, SetOptions(merge: true));

      if (_userProfile != null) {
        _userProfile = UserProfileModel(
          uid: _userProfile!.uid,
          name: name.trim(),
          email: _userProfile!.email,
          phone: phone.trim(),
          address: address.trim(),
        );
      }
      return true;
    } catch (e) {
      debugPrint("Firestore Update Profile Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
