import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';
import 'package:isar/isar.dart';

part 'habit_model.g.dart';

@Collection()
class HabitModel extends HabitEntity{

  @Id()
  int id = 0;

  HabitModel({required super.title, required super.description});

  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      title: entity.title,
      description: entity.description
    );
  }
}