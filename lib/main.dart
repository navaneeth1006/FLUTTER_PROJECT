import 'package:flutter/material.dart';
import 'app.dart';
import 'services/local_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Safely initialize sample data for preserved services
  try {
    final localDataService = LocalDataService();
    await localDataService.initializeSampleData();
  } catch (_) {
    // Graceful fallback if storage is uninitialized in headless test environments
  }

  runApp(const EcoStepsApp());
}

/// Backward compatibility alias for existing test suites.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const EcoStepsApp();
  }
}
