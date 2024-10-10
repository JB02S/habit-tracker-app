import 'package:get_it/get_it.dart';
import 'package:habit_tracker_app/features/habit_tracker/data/data_sources/local/habits_database.dart';
import 'package:habit_tracker_app/features/habit_tracker/data/repositories/habit_repository_impl.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/add_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/delete_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/use_cases/get_habit_usecase.dart';
import 'package:habit_tracker_app/features/habit_tracker/presentation/bloc/habit_bloc.dart';

final locater = GetIt.instance;

Future<void> initialiseDepenencies() async {

  locater.registerSingleton<HabitsDatabase>(
    HabitsDatabaseImpl()
  );

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
  locater.registerSingleton<DeleteHabitUsecase>(
    DeleteHabitUsecase(locater())
  );

  // BLoC's
  locater.registerFactory<HabitBloc>(
    () => HabitBloc(locater(), locater(), locater())
  );



}