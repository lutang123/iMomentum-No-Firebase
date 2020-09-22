import 'dart:io';
import 'package:iMomentum/screens/iTodo/todo_screen/todo_model/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDBHelper {
  //Named constructor to create instance of DatabaseHelper
  //this is our constructor
  TodoDBHelper._instance();
  static final TodoDBHelper instance = TodoDBHelper._instance();

  static Database _db;

  String tasksTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colStatus = 'status'; //must have status?

  // Task Tables
  // Id | Title | Date | Status
  // 0     ''      ''      0
  // 1     ''      ''      1
  // 2     ''      ''      0

  //this is a getter for our database variable
  Future<Database> get fetchMyDatabase async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  //1. Add the dependencies
  //2. Define the data model
  //3. Init/openDatabase the database
  //4. Create the table
  Future<Database> _initDb() async {
    //we create a dir from path_provider method
    Directory dir = await getApplicationDocumentsDirectory();
    //we go to our current path and then make a new file called todo_list.db
    String path = dir.path + '/todo_list.db';
    //openDatabase
    final todoListDb =
        //we use sqflite package function openDatabase
        await openDatabase(path, version: 1, onCreate: _createTable);
    return todoListDb;
  }

  void _createTable(Database db, int version) async {
    //we use sqflite package function db.execute(sql)
    await db.execute(
      'CREATE TABLE $tasksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colStatus INTEGER)',
    );
  }

  // 5. Retrieve the list of object
  //This is to get all the rows from sql table and then covert to objects
  Future<List<TodoModel>> getTodoList() async {
    Database db = await fetchMyDatabase;
    final List<Map<String, dynamic>> mapsList = await db.query(tasksTable);
    final List<TodoModel> todoList = [];
    mapsList.forEach((map) {
      todoList.add(TodoModel.fromMap(map));
    });
    todoList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    //this return type is TASK
    return todoList;
  }

//  //return todos or return int?
//  Future<TodoModel> insertTodo(TodoModel todos) async {
//    Database db = await fetchMyDatabase;
//    //Future<int> insert(String table, Map<String, dynamic> values)
//    todos.id = await db.insert(
//      tasksTable,
//      todos.toMap(),
//      conflictAlgorithm: ConflictAlgorithm.replace,
//    );
//    return todos;
//  }

  //6. Insert a Dog into the database
  Future<int> insertTodo(TodoModel task) async {
    Database db = await fetchMyDatabase;
    //Future<int> insert(String table, Map<String, dynamic> values)
    final int result = await db.insert(
      tasksTable,
      task.toMap(),
      //Insert the Dog into the correct table. You might also specify the
      //`conflictAlgorithm` to use in case the same dog is inserted twice.
      // In this case, replace any previous data.
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  //7. update
  Future<int> updateTodo(TodoModel todo) async {
    Database db = await fetchMyDatabase;
    final int result = await db.update(
      tasksTable, //table
      todo.toMap(), //value, type is map
      where: '$colId = ?', //this is argument
      whereArgs: [todo.id],
    );
    //return the updated row
    return result;
  }

  //8.delete
  Future<int> deleteTask(int id) async {
    Database db = await fetchMyDatabase;
    final int result = await db.delete(
      tasksTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  //close connection, not use?
  Future closeDBConnection() async {
    Database db = await fetchMyDatabase;
    db.close();
  }
}
