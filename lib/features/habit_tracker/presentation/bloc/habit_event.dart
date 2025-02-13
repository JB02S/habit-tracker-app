import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

abstract class HabitEvent {
  const HabitEvent();
}

class GetHabitsEvent extends HabitEvent {
  const GetHabitsEvent();
}

class AddHabitEvent extends HabitEvent {
  final HabitEntity _habit;
  HabitEntity get habit => _habit;
  const AddHabitEvent(this._habit);
}

class DeleteHabitEvent extends HabitEvent {
  final HabitEntity _habit;
  HabitEntity get habit => _habit;
  const DeleteHabitEvent(this._habit);
}
