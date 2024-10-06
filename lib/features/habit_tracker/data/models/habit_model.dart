import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

class HabitModel extends HabitEntity{

  HabitModel({required super.title, required super.description});

  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      title: entity.title,
      description: entity.description
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}