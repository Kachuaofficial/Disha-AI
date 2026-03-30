import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                const Spacer(),

                /// TOP ILLUSTRATION
                SvgPicture.asset('assets/images/ai.svg', height: 160),

                const SizedBox(height: 20),

                /// TITLE
                const Text(
                  "Welcome to Disha AI",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Your Personalized Ai Career Mentor",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),

                const Spacer(),

                /// GOOGLE BUTTON
                _socialButton(
                  text: "Continue with Google",
                  color: Colors.white,
                  textColor: Colors.black,
                  icon: Icons.g_mobiledata,
                ),

                const SizedBox(height: 12),

                /// APPLE BUTTON
                _socialButton(
                  text: "Continue with Apple",
                  color: const Color(0xFFB8F2A1),
                  textColor: Colors.black,
                  icon: Icons.apple,
                ),

                const SizedBox(height: 12),

                /// GUEST BUTTON
                _socialButton(
                  text: "Continue as Guest",
                  color: Colors.grey.shade200,
                  textColor: Colors.black87,
                  icon: Icons.person_outline,
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String text,
    required Color color,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
