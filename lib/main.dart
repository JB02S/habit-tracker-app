import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:habit_tracker_app/injection_container.dart';
import 'features/habit_tracker/presentation/bloc/habit_event.dart';
import 'features/habit_tracker/presentation/pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseDepenencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitBloc>(

      // get BLoC and call GetHabitsEvent
      create: (context) {
        final bloc = locater<HabitBloc>();
        bloc.add(const GetHabitsEvent());
        return bloc;
      },

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


