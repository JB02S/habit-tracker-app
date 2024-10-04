import 'package:flutter/material.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_provider.dart';
import 'package:provider/provider.dart';
import 'features/habit_tracker/presentation/pages/home_page.dart';


void main() async {
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


