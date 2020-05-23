final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class TodoModel {
  int id;
  final String title;
  DateTime date;
  int status; // 0 - Incomplete, 1 - Complete
//  bool isDone;

  TodoModel({
    this.id,
    this.title,
    this.date,
    this.status,
//    this.isDone = false,
  });

  //this is a named constructor
//  TodoModel.withId({
//    this.id,
//    this.title,
//    this.date,
//  });

//  void toggleDone() {
//    isDone = !isDone;
//  }

  //when we store our task object into sql database, we have to convert our task to a map
  Map<String, dynamic> toMap() {
    //we then need to assign the keys of the map to the corresponding values
    final map = Map<String, dynamic>();
    //we then need to assign the keys of the map to the corresponding values
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['status'] = status;
    return map;
  }

//  Map<String, dynamic> toMap() {
//    var map = <String, dynamic>{
//      columnTitle: title,
//      columnDone: done == true ? 1 : 0
//    };
//    if (id != null) {
//      map[columnId] = id;
//    }
//    return map;
//  }

  //factory function allow you to return objects and constructors
  //so we take map and return Task.withId
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      //parse map to object
      date: DateTime.parse(map['date']),
      status: map['status'],
    );
  }
}
