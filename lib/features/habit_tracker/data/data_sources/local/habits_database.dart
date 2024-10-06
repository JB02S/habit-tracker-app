import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:habit_tracker_app/features/habit_tracker/data/models/habit_model.dart';

abstract class HabitsDatabase {
  Future<void> createHabit(HabitModel habit);
}

class HabitsDatabaseImpl extends HabitsDatabase {

  Database? _database;

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'habits.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE habits(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)'
        );
      },
      version: 1,
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  @override
  Future<void> createHabit(HabitModel habit) async {
    final db = await database;
    await db.insert(
      'habits',
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

