
import 'package:habit_tracker_app/features/habit_tracker/data/data_sources/local/habits_database.dart';
import 'package:habit_tracker_app/features/habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {

  final HabitsDatabase habitsDatabase;

  HabitRepositoryImpl(this.habitsDatabase);

  @override
  Future<void> createHabit(HabitEntity habit) async {
    HabitModel habitModel = HabitModel.fromEntity(habit);
    await habitsDatabase.createHabit(habitModel);
  }

  @override
  Future<void> getHabits() {
    // TODO: implement getHabit
    throw UnimplementedError();
  }

}