
import 'package:habit_tracker_app/features/habit_tracker/data/models/habit_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Service class for opening isar database, use getit service locater to access

class DatabaseService {

  static Future<Isar> initDatabase() async {



    final dir = await getApplicationDocumentsDirectory();

    return await Isar.open(
      schemas: [HabitModelSchema],
      directory: dir.path
    );
  }
}