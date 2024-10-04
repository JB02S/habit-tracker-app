import '../../domain/entities/habit_entity.dart';

abstract class HabitEvent {
  const HabitEvent();
}

class GetHabitsEvent extends HabitEvent {
  const GetHabitsEvent();
}

class AddHabitEvent extends HabitEvent {
  final HabitEntity habit;

  const AddHabitEvent(this.habit);
}
