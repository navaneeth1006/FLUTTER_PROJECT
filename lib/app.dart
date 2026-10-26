import 'package:flutter/material.dart';
import 'screens/completion_screen.dart';
import 'screens/home_screen.dart';
import 'screens/recycling_step_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

/// The root application widget for EcoSteps.
class EcoStepsApp extends StatelessWidget {
  const EcoStepsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSteps – Animated Recycling Guide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/home': (_) => const HomeScreen(),
        '/completion': (_) => const CompletionScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/step') {
          final args = settings.arguments as Map<String, dynamic>?;
          final stepIndex = (args != null && args['index'] is int)
              ? args['index'] as int
              : 0;
          return MaterialPageRoute(
            builder: (_) => RecyclingStepScreen(stepIndex: stepIndex),
          );
        }
        return null;
      },
    );
  }
}
