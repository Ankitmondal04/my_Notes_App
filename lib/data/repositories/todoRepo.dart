import 'package:my_notes/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepo {
  static final String tableName = "myToDo";
  static final String columnSnO = "S_No";
  static final String columnTasks = "Tasks";
  static final String columnStatus = "IsCompleted";

  static final String todoTable =
      '''
    CREATE TABLE $tableName (
      $columnSnO INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTasks TEXT,
      $columnStatus INTEGER
    )
  ''';

  Database? _myDatabase;

  Future<Database> get database async {
    _myDatabase ??= await Data().getDB();
    return _myDatabase!;
  }

  Future<bool> addTasks({required String myTasks}) async {
    final myDB = await database;
    int rowsEffected = await myDB.insert(tableName, {
      columnTasks: myTasks,
      columnStatus: 0,
    });

    return rowsEffected > 0;
  }

  Future<bool> deleteTask({required int SnO}) async {
    final myDB = await database;
    int rowsDeleted = await myDB.delete(
      tableName,
      where: '$columnSnO = ?',
      whereArgs: [SnO],
    );
    return rowsDeleted > 0;
  }

  Future<bool> updateTask({required int SnO, required String newTask}) async {
    final myDB = await database;
    int rowsUpdated = await myDB.update(
      tableName,
      {columnTasks: newTask},
      where: '$columnSnO = ?',
      whereArgs: [SnO],
    );

    return rowsUpdated > 0;
  }

  // Future<bool> updateTask({required int SnO}) async {
  //   final myDB = await database;
  //   int rowsEffected = await myDB.update(
  //     tableName,
  //     where: 'id',
  //     whereArgs: [SnO],
  //   );
  //   return rowsEffected > 0;
  // }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final myDB = await database;
    List<Map<String, dynamic>> todoData = await myDB.query(tableName);

    return todoData;
  }
}
