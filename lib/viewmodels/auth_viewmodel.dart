class AuthViewModel {
  bool login(String email, String password) {
    if (email == "admin" && password == "1234") {
      return true;
    }
    return false;
  }
}