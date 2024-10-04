import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';

class GetHabitsUsecase {
  final HabitRepository _repository;

  GetHabitsUsecase(this._repository);

  Future<void> execute() async {
    await _repository.getHabits();
  }
}