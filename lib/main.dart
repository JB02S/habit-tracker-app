import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/core/services/database_service.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/get_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/injection_container.dart';
import 'package:provider/provider.dart';
import 'features/habit_tracker/presentation/bloc/habit_event.dart';
import 'features/habit_tracker/presentation/pages/home_page.dart';
import 'package:get_it/get_it.dart';


void main() async {
  await initialiseDepenencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitBloc>(

      // Use create function to instantiate BLoC, use locater to
      create: (context) => locater..add(GetHabitsEvent()),


      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          textTheme: Typography.blackHelsinki
        )
      ),
    );
  }
}


