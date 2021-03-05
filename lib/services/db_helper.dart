import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colDone = "isDone";
  String colDate = "date";

  DbHelper._internal();

  factory DbHelper() => _dbHelper;

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tblTodo($colId integer primary key, $colTitle TEXT, $colDescription TEXT, $colDone INTEGER, $colDate TEXT)");
  }

  Future<int> insertTodo(Todo _todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, _todo.toMap());
    return result;
  }

  Future<int> getAllTodosCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT (*) FROM $tblTodo'));
    return result;
  }

  Future<List<Todo>> getAllTodos() async {
    List<Todo> _todos = [];
    Database db = await this.db;
    var result = await db.rawQuery('SELECT * FROM $tblTodo');
    result.forEach((d) => _todos.add(Todo.fromMap(d)));
    return _todos;
  }

  Future<List<Todo>> getDoneTodos() async {
    List<Todo> _todos = [];
    Database db = await this.db;
    var result = await db.rawQuery(
      'SELECT * FROM $tblTodo WHERE $colDone = ?',
      [1],
    );
    result.forEach((d) => _todos.add(Todo.fromMap(d)));
    return _todos;
  }

  Future<List<Todo>> getUnDoneTodos() async {
    List<Todo> _todos = [];
    Database db = await this.db;
    var result = await db.rawQuery(
      'SELECT * FROM $tblTodo WHERE $colDone = ?',
      [0],
    );
    result.forEach((d) => _todos.add(Todo.fromMap(d)));
    return _todos;
  }

  Future<Todo> getTodo(int id) async {
    Database db = await this.db;
    List<Map> maps = await db.query(tblTodo,
        columns: [colId, colDone, colTitle, colDescription], where: '$colId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateTodo(Todo _todo) async {
    Database db = await this.db;
    var result =
        await db.update(tblTodo, _todo.toMap(), where: "$colId = ?", whereArgs: [_todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    Database db = await this.db;
    var result = await db.delete(tblTodo, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteEveryThing() async {
    Database db = await this.db;
    var result = await db.delete(tblTodo);
    return result;
  }
}
//TODO: veri tabanı yapılacak beceremedik !!!
