import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

class HabitModel extends HabitEntity{

  final int? id;

  HabitModel({this.id, required super.title, required super.description});

  // Convert from Entity to HabitModel
  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      id: entity.id,
      title: entity.title,
      description: entity.description
    );
  }

  // Convert from HabitModel to Entity
  HabitEntity toEntity() {
    return HabitEntity(
      id: id,
      title: title,
      description: description
    );
  }

  // Convert from Map to HabitModel
  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}