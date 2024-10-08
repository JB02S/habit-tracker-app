import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/features/habit_tracker/domain/entities/habit_entity.dart';

class DetailPage extends StatelessWidget {
  final HabitEntity habit;
  const DetailPage({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
        centerTitle: true,
      ),
    );
  }
}
