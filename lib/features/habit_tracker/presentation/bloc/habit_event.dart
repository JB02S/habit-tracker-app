import '../../domain/entities/habit_entity.dart';

abstract class HabitEvent {}

class FetchHabitsEvent extends HabitEvent {}

class AddHabitEvent extends HabitEvent {
  final HabitEntity habit;

  AddHabitEvent(this.habit);
}
