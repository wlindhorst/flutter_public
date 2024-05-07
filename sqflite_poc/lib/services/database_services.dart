import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_poc/models/task.dart';

class DatabaseService {
  static Database? _db;
  // To enforce only one database instance, do this:
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksContentColumnName = "content";
  final String _tasksStatusColumnName = "status";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      db.execute('''
            CREATE TABLE $_tasksTableName (
              $_tasksIdColumnName INTEGER PRIMARY KEY,
              $_tasksContentColumnName TEXT NOT NULL,
              $_tasksStatusColumnName INTEGER NOT NULL
            )''');
    });
    return database;
  }

  void addTask(
    String content,
  ) async {
    final db = await database;
    await db.insert(
      _tasksTableName,
      {_tasksContentColumnName: content, _tasksStatusColumnName: 0},
    );
  }

  Future<List<Task>?> getTask() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    List<Task> task = data
        .map(
          (e) => Task(
            id: e["id"] as int,
            status: e["status"] as int,
            content: e["content"] as String,
          ),
        )
        .toList();

    return task;
  }
}


// in the case of tables changing - review onUpgrade: and onDowngrade: on the openDatabase method