import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

abstract class HabitRepository {
  Future<void> createHabit(HabitEntity habit);
  Future<List<HabitEntity>> getHabits();
} 