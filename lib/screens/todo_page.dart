import 'package:flutter/material.dart';
import 'package:iMomentum/screens/todo_card.dart';
import 'package:iMomentum/todo_model/todo_database.dart';
import 'package:iMomentum/todo_model/todo_model.dart';
import 'add_todo.dart';
import 'package:iMomentum/constants.dart';

//https://image-color-picker.com/

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  //start with a list, type is Future, make it =[]? or not??
  Future<List<TodoModel>> _todoList;

  @override
  void initState() {
    super.initState();
    //because this function returns a future, we need wrap our ViewList to a FutureBuilder
    _updateTodoList();
  }

  void _updateTodoList() {
    setState(() {
      //getTodoList() is from database_helper.dart, it returns Future<List<Task>>
      //DatabaseHelper.instance to call the method
      _todoList = TodoDBHelper.instance.getTodoList();
    });
  }

  bool fabVisible = true;
//  void showFab(bool value) {
//    setState(() {
//      fabVisible = value;
//    });
//  }
  void toggleFab() {
    setState(() {
      fabVisible = !fabVisible;
    });
  }

  void _onChangedCallBack(bool newValue, TodoModel todo) {
    todo.status = newValue ? 1 : 0; //if value is true, status is 1
    //not using setState but each task has an status, and when
    //click, we update the task by id, because it's status changed
    TodoDBHelper.instance.updateTodo(todo);
    //we need to update the task list, this function already has setState()
    _updateTodoList();
  }

  void _onLongPressCallBack(TodoModel todo) {
    TodoDBHelper.instance.deleteTask(todo.id);
    //we need to update the task list, this function already has setState()
    _updateTodoList();
    //better to show SnackBar or not?
    final deleteSnackBar = SnackBar(
      backgroundColor: Colors.white12,
      content: Text('removed your todo'),
    );
    Scaffold.of(context).showSnackBar(deleteSnackBar);
  }

  void _onTapCallBack(TodoModel todo) {
    var bottomSheetController = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          AddTodoScreen(updateTodoList: _updateTodoList, todo: todo),
    );
    toggleFab();
    bottomSheetController.then((value) => toggleFab());
  }

  void _fabCallBack() {
    var bottomSheetController = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddTodoScreen(updateTodoList: _updateTodoList),
    );
    toggleFab();
    bottomSheetController.then((value) => toggleFab());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.todoImage),
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
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
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
                              return TodoCard(
                                todo: snapshot.data[index - 1],
                                onChangedCallBack: _onChangedCallBack,
                                onLongPressCallBack: _onLongPressCallBack,
                                onTapCallBack: _onTapCallBack,
                              );
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
                onPressed: _fabCallBack,
              ),
            )
          : Container(),
    );
  }
}
