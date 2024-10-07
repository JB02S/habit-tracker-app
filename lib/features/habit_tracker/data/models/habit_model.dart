import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

class HabitModel extends HabitEntity{

  HabitModel({required super.title, required super.description});

  // Convert from Entity to HabitModel
  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      title: entity.title,
      description: entity.description
    );
  }

  // Convert from Map to HabitModel
  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      title: map['title'],
      description: map['description'],    
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}