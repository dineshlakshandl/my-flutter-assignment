import 'package:flutter/material.dart';
import '../../app/routes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), 
      body: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10), 
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),

              const Text(
                "FASHION STORE",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'serif', 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Create a new account",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'serif',
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A), 
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white12), 
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white54, fontSize: 16),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF97316), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(
                    color: Color(0xFFF97316),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'serif',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}