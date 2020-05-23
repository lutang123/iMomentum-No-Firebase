import 'package:flutter/material.dart';
import 'package:iMomentum/todo_model/todo_database.dart';
import 'package:iMomentum/todo_model/todo_model.dart';
//import 'package:noteapp/todo_widgets/todo_list.dart';
import 'package:intl/intl.dart';

import 'add_todo.dart';

//https://image-color-picker.com/

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  Future<List<TodoModel>> _todoList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  bool fabVisible = true;

  @override
  void initState() {
    super.initState();
    //because this function returns a future, we need to wrap our ViewList to a FutureBuilder
    _updateTodoList();
  }

  void _updateTodoList() {
    setState(() {
      //getTodoList() is from database_helper.dart, it returns Future<List<Task>>
      //DatabaseHelper.instance to call the method
      _todoList = TodoDBHelper.instance.getTodoList();
    });
  }

  void showFab(bool value) {
    setState(() {
      fabVisible = value;
    });
  }

  Widget _buildTodo(TodoModel todo) {
    return Card(
      color: Colors.white10,
      child: ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 25.0,
              decoration: todo.status == 0 ? null : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(
            '${_dateFormatter.format(todo.date)}',
            style: TextStyle(
              fontSize: 15.0,
              decoration: todo.status == 0 ? null : TextDecoration.lineThrough,
            ),
          ),
          trailing: Checkbox(
            activeColor: Color(0xff02abd4),
            value: todo.status == 1 ? true : false,
            onChanged: (newValue) {
              todo.status = newValue ? 1 : 0; //if value is true, status is 1
              //not using setState but each task has an status, and when
              //click, we update the task by id, because it's status changed
              TodoDBHelper.instance.updateTodo(todo);
              //we also need to update the task list, this function has
              // setState()
              _updateTodoList();
            },
          ),
          onLongPress: () {
            TodoDBHelper.instance.deleteTask(todo.id);
            _updateTodoList();
            final deleteSnackBar = SnackBar(
              backgroundColor: Colors.white12,
              content: Text('removed your todo'),
            );
            Scaffold.of(context).showSnackBar(deleteSnackBar);
          },
          onTap: () {
            var bottomSheetController = showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTodoScreen(
                      updateTodoList: _updateTodoList, todo: todo),
                ),
              ),
            );
            showFab(false);
            bottomSheetController.then((value) {
              showFab(true);
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/todo_image.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          iconSize: 40,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'My Todo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
//                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                        topLeft: Radius.circular(20.0),
//                        topRight: Radius.circular(20.0),
                  ),
                  child: FutureBuilder(
                    future: _todoList,
                    builder: (context, snapshot) {
                      final int completedTaskCount = snapshot.data
                          .where((TodoModel todo) => todo.status == 1)
                          .toList()
                          .length;
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$completedTaskCount of ${snapshot.data.length}',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }
                              return _buildTodo(snapshot.data[index - 1]);
                            });
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 30),
                        child: Text(
                          'Add ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
//
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: fabVisible
          ? Visibility(
              visible: fabVisible,
              child: FloatingActionButton(
                backgroundColor: Color(0xff02abd4),
                child: Icon(
                  Icons.add,
                  color: Colors.white70,
                  size: 30,
                ),
                onPressed: () {
                  var bottomSheetController = showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTodoScreen(updateTodoList: _updateTodoList),
                      ),
                    ),
                  );
                  showFab(false);
                  bottomSheetController.then((value) {
                    showFab(true);
                  });
                },
              ),
            )
          : Container(),
    );
  }
}
