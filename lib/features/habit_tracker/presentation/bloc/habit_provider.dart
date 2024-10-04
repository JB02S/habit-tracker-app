
import 'package:flutter/cupertino.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

class HabitProvider extends ChangeNotifier {

  List<HabitEntity> _habits = [];
  List<HabitEntity> get habits => _habits;

  void createAndAddNewHabit(String title, String description) {
    _habits.add(HabitEntity(title: title, description: description));
    notifyListeners();
  }

}