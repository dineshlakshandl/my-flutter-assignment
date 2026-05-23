import 'package:flutter/material.dart';
import '../app/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //REGISTER USER METHOD
  Future<bool> registerUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.registerWithEmail(email, password);
      _isLoading = false;
      notifyListeners();
      return true; 
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false; 
    }
  }

  //LOGIN USER METHOD
  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.loginWithEmail(email, password);
      _isLoading = false;
      notifyListeners();
      return true; 
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false; 
    }
  }

  Future<void> logoutUser() async {
    try {
      await _authService.logout();
    } catch (e) {
      print("Logout failed: $e");
    }
  }
}