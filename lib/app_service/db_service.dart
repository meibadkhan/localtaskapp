 import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../app_models/task_model.dart';

class DatabaseHelper {
  static const _databaseName = 'tasks.db';
  static const _tableName = 'tasks';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            task_name TEXT NOT NULL,
            description TEXT NOT NULL,
            is_complete INTEGER NOT NULL,
            date_added TEXT NOT NULL
          )
        ''');
        });
  }

  Future<List<Task>> getAllTasks() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> insertTask(Task task) async {
    Database db = await instance.database;
    return await db.insert(_tableName, task.toMap());
  }

  Future<int> updateTask(Task task) async {

    Database db = await instance.database;
 return   await db.update(_tableName, task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int taskId) async {
    Database db = await instance.database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [taskId]);
  }
}

