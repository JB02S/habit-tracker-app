
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
  Future<List<HabitEntity>> getHabits() async {

    // fetch raw data
    List<Map<String, dynamic>> rawHabits = await habitsDatabase.readHabits();

    // conversion from raw data into models
    final List<HabitModel> habitModels = rawHabits.map((habitMap) => HabitModel.fromMap(habitMap)).toList();

    // conversion from models into entities
    final List<HabitEntity> habits = habitModels.map((habitModel) => habitModel.toEntity()).toList();

    return habits;
  }

  @override
  Future<void> deleteHabit(HabitEntity habit) async {
    HabitModel habitModel = HabitModel.fromEntity(habit);
    await habitsDatabase.deleteHabit(habitModel);
  }

}