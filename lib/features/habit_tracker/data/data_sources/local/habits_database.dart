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
      }
    );
  }

  @override
  Future<void> createHabit(HabitModel habit) {
    // TODO: implement createHabit
    throw UnimplementedError();
  }
}

