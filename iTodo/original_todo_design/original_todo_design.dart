import 'package:flutter/material.dart';
import 'package:iMomentum/screens/iTodo/todo_screen/todo_card.dart';
import 'package:iMomentum/screens/iTodo/todo_screen/todo_model/todo_db_helper.dart';
import 'package:iMomentum/screens/iTodo/todo_screen/todo_model/todo_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iMomentum/screens/iMeditate/constants/theme.dart';
import 'package:iMomentum/screens/iMeditate/utils/utils.dart';
import 'add_todo.dart';

//We are not using FutureBuilder as it creates problem by restarting the
// asynchronous task every time the widget rebuild.

//https://image-color-picker.com/

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  //start with a list, type is Future, make it =[]? or not??
  Future<List<TodoModel>> _todoList;

  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  DateTime _selectedDate;
  TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    //because this function returns a future, we need wrap our ViewList to a FutureBuilder
    _updateTodoList();

    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
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
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
//          Image.asset('images/ocean2.jpg', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ],
                stops: [0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 40,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'iTodo',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8.0, right: 8, top: 10),
                    decoration: BoxDecoration(
                      color: isDark(context) ? darkSurface : lightSurface,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: TableCalendar(
                      calendarController: _calendarController,
                      events: _events,
                      initialCalendarFormat: CalendarFormat.week,
                      calendarStyle: CalendarStyle(
                        markersColor: Colors.purple,
                        todayColor: Colors.blueGrey,
                        selectedColor: Colors.blue,
                        todayStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonDecoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        formatButtonTextStyle: TextStyle(color: Colors.white),
                        formatButtonShowsNext: false,
                      ),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected: (date, events) {
                        setState(() {
//                  print(date.toIso8601String());
                          _selectedEvents = events;
                          _selectedDate = date;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 8.0, right: 8, top: 10),
                      decoration: BoxDecoration(
                        color: isDark(context) ? darkSurface : lightSurface,

//                        color: Colors.white10,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0)),
                      ),
                      child: FutureBuilder(
                        future: _todoList,
                        builder: (context, snapshot) {
                          //if not data
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

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
                                'Add your todo here!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: fabVisible
                ? Visibility(
                    visible: fabVisible,
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
//                backgroundColor: Color(0xff006994),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      tooltip: 'Add',
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.white, width: 2.0)),
                      onPressed: _fabCallBack,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

//          ),
//        ],
//      ),
//    );
//  }
//    return Scaffold(
//      body: Stack(
//        children: <Widget>[
////          Image.asset(Constants.todoImage, fit: BoxFit.cover),
////          Container(
////            decoration: BoxDecoration(
////              gradient: LinearGradient(
////                colors: [
////                  Colors.transparent,
////                  Colors.black54,
////                ],
////                stops: [0.5, 1.0],
////                begin: Alignment.topCenter,
////                end: Alignment.bottomCenter,
////                tileMode: TileMode.repeated,
////              ),
////            ),
////          ),
//          Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage(Constants.todoImage),
//                fit: BoxFit.cover,
////                colorFilter: ColorFilter.mode(
////                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
//              ),
//            ),
//            child:
}
