import 'package:get_it/get_it.dart';
import 'package:habit_tracker_app/features/habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/add_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/get_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';
import 'package:isar/isar.dart';

import 'core/services/database_service.dart';

final locater = GetIt.instance;

Future<void> initialiseDepenencies() async {

  // Initialise database
  final isar = await DatabaseService.initDatabase();

  // Dependencies
  locater.registerSingleton<Isar>(isar);
  locater.registerSingleton<HabitRepository>(
    HabitRepositoryImpl(locater())
  );

  // UseCases
  locater.registerSingleton<AddHabitUsecase>(
    AddHabitUsecase(locater())
  );
  locater.registerSingleton<GetHabitsUsecase>(
    GetHabitsUsecase(locater())
  );

  // BLoC's
  locater.registerFactory<HabitBloc>(
    () => HabitBloc(locater(), locater())
  );



}