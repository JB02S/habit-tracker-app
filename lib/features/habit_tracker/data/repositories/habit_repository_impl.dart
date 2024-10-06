
import 'package:habit_tracker_app/features/habit_tracker/data/models/habit_model.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/repositories/habit_repository.dart';
import 'package:isar/isar.dart';

class HabitRepositoryImpl implements HabitRepository {

  final Isar _isar;

  HabitRepositoryImpl(this._isar);

  @override
  Future<void> createHabit(HabitEntity habit) async {

    HabitModel habitModel = HabitModel.fromEntity(habit);
    print(habitModel.id);
    print(habitModel.title);
    print(habitModel.description);
    print("*********\n*****************\n*****************\n*****************\n*****************\n********");

    HabitModel habitModel2 = HabitModel(title: "awda", description: "ADWA");
    print(habitModel2.id);
    print(habitModel2.title);
    print(habitModel2.description);
    print("*********\n*****************\n*****************\n*****************\n*****************\n********");

    await _isar.writeTxn((isar) {
      _isar.habitModels.put(habitModel);
    });

    print("added");
  }

  @override
  Future<void> getHabits() {
    // TODO: implement getHabit
    throw UnimplementedError();
  }

}