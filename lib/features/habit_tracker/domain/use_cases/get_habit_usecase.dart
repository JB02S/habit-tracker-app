import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';

class GetHabitsUsecase {
  final HabitRepository _repository;

  GetHabitsUsecase(this._repository);

  Future<List<HabitEntity>> execute() async {
    return await _repository.getHabits();
  }
}