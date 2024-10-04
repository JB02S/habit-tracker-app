import 'package:flutter/material.dart';
import 'package:habit_tracker_app/core/services/database_service.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_provider.dart';
import 'package:provider/provider.dart';
import 'features/habit_tracker/presentation/pages/home_page.dart';
import 'package:get_it/get_it.dart';


void main() async {

  // Returns our isar instance for CRUD operations
  final isar = DatabaseService.initDatabase();

  // Create locater for depedency injection
  final locater = GetIt.instance;

  // Add isar database service to locater as singleton to prevent multiple read / write operations to db simultaneously
  locater.registerSingleton(isar);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        textTheme: Typography.blackHelsinki
      )
    );
  }
}


