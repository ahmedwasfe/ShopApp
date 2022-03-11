import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // static final DBHelper _instance = DBHelper.internal();
  // factory DBHelper() => _instance;
  // DBHelper.internal();
  static Database? database;

  final String _TABLE_NAME = "tasks";
  final String _ID = "id";
  final String _TITLE = "title";
  final String _DATE = "date";
  final String _TIME = "time";
  final String _STATUS = "status";

  Future<Database> createDatabase() async {
    if (database != null) {
      return database!;
    }
    database =
        await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print("onCreate: Database created");
      String sql =
          'CREATE TABLE $_TABLE_NAME ($_ID INTEGER PRIMARY KEY AUTOINCREMENT, $_TITLE TEXT, $_DATE TEXT, $_TIME TEXT, $_STATUS TEXT)';
      db
          .execute(sql)
          .then((value) => print("onCreate: Table created"))
          .catchError((error) => print("catchError: ${error.toString()}"));
    }, onOpen: (db) {
      print("onOpen: Database opened");
    });

    return database!;
  }

  Future insertTaskToDB({
    required String title,
    required String time,
    required String date,
  }) async {
    Database db = await createDatabase();
    return await db.transaction((txn) async {
      String sql =
          "INSERT INTO $_TABLE_NAME($_TITLE, $_DATE, $_TIME, $_STATUS) VALUES('$title', '$date', '$time', 'New')";
      txn.rawInsert(sql).then((value) {
        print("then: $value inserted success");
      }).catchError((error) => print("catchError: ${error.toString()}"));
    });
  }

  Future<List<Map>> getTasksFromDB() async {
    Database db = await createDatabase();
    String sql = 'SELECT * FROM $_TABLE_NAME';
    return await db.rawQuery(sql);
  }

  Future updateTask({
    required String status,
    required int id
  }) async {
    Database db = await createDatabase();
    String sql = 'UPDATE $_TABLE_NAME SET $_STATUS = ? WHERE $_ID = ?';
    var values = ['$status', id];
    db.rawUpdate(sql, values).then((value) {
      print("then: $value updated success");
    });
  }

  Future deleteTask({
    required int id
  }) async {
    Database db = await createDatabase();
    String sql = 'DELETE FROM $_TABLE_NAME WHERE $_ID = ?';
    var values = [id];
    db.rawDelete(sql, values).then((value) {
      print("then: $value Delete success");
    });
  }

  Future<List<Map>> getTasksNew() async {
    Database db = await createDatabase();
    String sql = 'SELECT * FROM $_TABLE_NAME WHERE $_STATUS = "New"';
    return await db.rawQuery(sql);
  }

  Future<List<Map>> getTasksDone() async {
    Database db = await createDatabase();
    String sql = 'SELECT * FROM $_TABLE_NAME WHERE $_STATUS = "Done"';
    return await db.rawQuery(sql);
  }

  Future<List<Map>> getTasksArchived() async {
    Database db = await createDatabase();
    String sql = 'SELECT * FROM $_TABLE_NAME WHERE $_STATUS = "Archived"';
    return await db.rawQuery(sql);
  }
}
