import 'package:my_notes/data/database.dart';
import 'package:sqflite/sqflite.dart';

class NotesRepo {
  static final String tableName = "myNotes";
  static final String columnSno = "S_N0";
  static final String columnTitle = "Title";
  static final String columnText = "Text";
  static final String columnDateTime = "Date_Time";

  static final String notesTable =
      '''
  CREATE TABLE $tableName(
    $columnSno INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnTitle TEXT,
    $columnText TEXT,
    $columnDateTime TEXT
  )
  ''';

  Database? _myDatabase;

  Future<Database> get database async {
    _myDatabase ??= await Data().getDB();
    return _myDatabase!;
  }

  Future<bool> addNotes({
    required String myTitle,
    required String myText,
    required DateTime dateModified,
  }) async {
    final myDB = await database;
    int rowsEffected = await myDB.insert(tableName, {
      columnTitle: myTitle,
      columnText: myText,
      columnDateTime: dateModified.toIso8601String(),
    });

    return rowsEffected > 0;
  }

  Future<bool> deleteNote({required String dateModified}) async {
    final myDB = await database;
    int rowsdeleted = await myDB.delete(
      tableName,
      where: "$columnDateTime = ?",
      whereArgs: [dateModified],
    );

    return rowsdeleted > 0;
  }

  Future<bool> updateNote({
    required int notesSnO,
    required String newTitle,
    required String newText,
    required DateTime newDateTime,
  }) async {
    final myDB = await database;
    int rowsUpdated = await myDB.update(
      tableName,
      {
        columnTitle: newTitle,
        columnText: newText,
        columnDateTime: newDateTime.toIso8601String(),
      },
      where: "$columnSno = ?",
      whereArgs: [notesSnO],
    );

    return rowsUpdated > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final myDB = await database;
    List<Map<String, dynamic>> notesData = await myDB.query(tableName);

    return notesData;
  }
}
