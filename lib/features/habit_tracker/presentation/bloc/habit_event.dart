import '../../domain/entities/habit_entity.dart';

abstract class HabitEvent {}

class GetHabitsEvent extends HabitEvent {}

class AddHabitEvent extends HabitEvent {
  final HabitEntity habit;

  AddHabitEvent(this.habit);
}
