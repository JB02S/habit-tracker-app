
import 'package:habit_tracker_app/features/habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:isar/isar.dart';

class HabitRepositoryImpl implements HabitRepository {

  final Isar _isar;

  HabitRepositoryImpl(this._isar);

  @override
  Future<void> createHabit(HabitEntity habit) async {

    await _isar.writeTxn(() async {
      await _isar.habitModels.put(HabitModel.fromEntity(habit));
    });
  }

  @override
  Future<void> getHabits() {
    // TODO: implement getHabit
    throw UnimplementedError();
  }

}