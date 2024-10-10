import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';

class DeleteHabitUsecase {
  final HabitRepository _repository;

  DeleteHabitUsecase(this._repository);

  Future<void> execute(HabitEntity habit) async {
    await _repository.deleteHabit(habit);
  }
}