import 'package:disha_ai/auth/auth_page.dart';
import 'package:disha_ai/resume_uploader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'onboarding/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (BuildContext context, GoRouterState state) =>
            const AuthPage(),
      ),
      GoRoute(
        path: '/resume',
        builder: (BuildContext context, GoRouterState state) =>
            const ResumeUploadPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Disha AI',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class AppColors {
  static const primaryGreen = Color(0xFFA8E6A3); // Apple button green
  static const lightGrey = Color(0xFFF2F2F2);   // background cards
  static const textPrimary = Color(0xFF1E1E1E);
  static const textSecondary = Color(0xFF8E8E93);
  static const accent = Color(0xFF6C63FF); // onboarding link color
}
