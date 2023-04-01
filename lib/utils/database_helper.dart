import "package:sqflite/sqflite.dart";
import "dart:async";
import "dart:io";
import "package:path_provider/path_provider.dart";
import "package:todo_app/models/task.dart";

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String taskTable = "tasks";
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

    var todoDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return todoDB;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'create table $taskTable($colId integer primary key autoincrement, $colTitle text, $colDescription text, $colDate text, $colStartTime text, $colEndTime text, $colStatus text)');
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

  Future<int> insertTask(Task task) async {
    Database db = await database;
    var res = await db.insert(taskTable, task.toMap());
    return res;
  }

  Future<int> updateTask(Task task) async {
    Database db = await database;
    var res = await db.update(taskTable, task.toMap(),
        where: '$colId=?', whereArgs: [task.id]);
    return res;
  }

  Future<int> deleteTask(Task task) async {
    Database db = await database;
    var res =
        await db.delete(taskTable, where: '$colId=?', whereArgs: [task.id]);
    return res;
  }

  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery("select count * from $taskTable");
    int res = Sqflite.firstIntValue(x)!;
    return res;
  }

  Future<List<Task>> getTaskList() async {
    var taskListAsMap = await getTasks();

    List<Task> taskList = [];

    for (var map in taskListAsMap) {
      taskList.add(Task.fromMapObject(map));
    }

    return taskList;
  }
}
