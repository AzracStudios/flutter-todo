import "package:sqflite/sqflite.dart";
import "dart:async";
import "dart:io";
import "package:path_provider/path_provider.dart";
import "package:todo_app/models/task.dart";
import "package:todo_app/models/task_status.dart";

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String taskTable = "tasks";
  String statusTable = "task_status";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colDate = "date";
  String colStartTime = "start_time";
  String colEndTime = "end_time";
  String colStatus = "status";
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }
  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = "${dir.path}todo.db";

    var todoDB = await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
    return todoDB;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'create table $statusTable($colId integer primary key autoincrement, $colTitle text unique)');
    await db.execute(
        'create table $taskTable($colId integer primary key autoincrement, $colTitle text, $colDescription text, $colDate text, $colStartTime text, $colEndTime text, $colStatus int, foreign key($colStatus) references $statusTable($colId))');
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = 1');
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await database;
    var res = await db.query(taskTable);
    return res;
  }
  Future<Task> getTaskWithId(int id) async {
    Database db = await database;
    var res = await db.query(taskTable, where: '$colId=?', whereArgs: [id]);
    return Task.fromMapObject(res[0]);
  }

  Future<List<Map<String, Object?>>> getTaskStatus() async {
    Database db = await database;

    var res = await db.rawQuery('select * from task_status');
    return res;
  }

  Future<List<TaskStatus>> getTaskStatusList() async {
    var taskListAsMap = await getTaskStatus();
    List<TaskStatus> statusList = [];

    for (var map in taskListAsMap) {
      statusList.add(TaskStatus.fromMapObject(map));
    }

    return statusList;
  }

  Future<TaskStatus> getTaskStatusWithId(int id) async {
    Database db = await database;
    var res = await db.rawQuery('select * from $statusTable where $colId=$id');
    return TaskStatus.fromMapObject(res[0]);
  }

  Future<int> insertTask(Task task) async {
    Database db = await database;
    var res = await db.insert(taskTable, task.toMap());