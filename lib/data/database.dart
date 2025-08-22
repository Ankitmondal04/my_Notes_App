import 'dart:io';
import 'package:my_notes/data/repositories/notesRepo.dart';
import 'package:my_notes/data/repositories/todoRepo.dart';
import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Data {
  Data._internal();

  static final Data _instance = Data._internal();

  factory Data() {
    return _instance;
  }

  Database? database;

  Future<Database> getDB() async {
    database ??= await openDB();

    return database!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "UserDB.db");

    return await openDatabase(
      dbPath,
      //Table Creation
      onCreate: (db, version) async {
        ///For Notes
        await db.execute(NotesRepo.notesTable);

        ///For To_Do's
        await db.execute(TodoRepo.todoTable);
      },
      version: 1,
    );
  }
}
