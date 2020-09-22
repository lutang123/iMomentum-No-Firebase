import 'package:flutter/material.dart';
import 'package:iMomentum/customized_widgets/customized_bottom_sheet.dart';
import 'package:iMomentum/screens/iMeditate/constants/theme.dart';

import 'package:iMomentum/screens/iTodo/todo_model/todo_db_helper.dart';
import 'package:iMomentum/screens/iTodo/todo_model/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iMomentum/screens/iMeditate/utils/utils.dart';
import 'add_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//We are not using FutureBuilder as it creates problem by restarting the
// asynchronous task every time the widget rebuild.

//https://image-color-picker.com/

class Todo extends StatefulWidget {
  final ScrollController scrollController;
  Todo({this.scrollController});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> with TickerProviderStateMixin {
  // Example holidays
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
    DateTime(2020, 6, 01): ['Children Day'],
  };

  //start with a list, type is Future, make it =[]? or not??
  Future<List<TodoModel>> _todoList;

  CalendarController _calendarController;
  TextEditingController _eventController;
  TextEditingController _dateController;
  AnimationController _animationController;

  SharedPreferences prefs;

  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  String _title = '';

  DateTime _initialDate;
  DateTime _calenderDate;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.get('events') ?? '{}')));
    });
  }

  // Encode Date Time Helper Method
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

//  Map<String, dynamic> toMap() {
//    Map<String, dynamic> newMap = {};
//    //we then need to assign the keys of the map to the corresponding values
//    if (id != null) {
//      newMap['id'] = id;
//    }
//    newMap['title'] = titleList;
//    newMap['date'] = date.toIso8601String();
//    newMap['status'] = status;
//    return newMap;
//  }

  // decode Date Time Helper Method
  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  void initState() {
    super.initState();
    //because this function returns a future, we need wrap our ViewList to a FutureBuilder
    _updateTodoList();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    _initialDate = DateTime.now();
    _calenderDate = DateTime.now();

    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _dateController = TextEditingController();

    _events = {};
    _selectedEvents = [];

    initPrefs();

//    if (widget.todo != null) {
//      _title = widget.todo.title;
//      _date = widget.todo.date;
//    }
    //to make sure when we first come to this page the date is shown there
    _dateController.text = _dateFormatter.format(_initialDate);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _calendarController.dispose();
    _eventController.dispose();
    _animationController.dispose();
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

  void _showBottomSheet() {
    var bottomSheetController = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _addNewTodoScreen(),
    );
    toggleFab();
    bottomSheetController.then((value) => toggleFab());
  }

//          AddTodoScreen(
//        updateTodoList: _updateTodoList,
//        onPressedCallBack: _addNewTodo,
//      ),
//    );

//          addNewTodoScreen(todo),

//

  SingleChildScrollView _addNewTodoScreen() {
    return SingleChildScrollView(
      child: CustomizedBottomSheet(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              readOnly: true,
              textAlign: TextAlign.center,
              controller: _dateController,
              onTap: _handleDatePicker,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            TextField(
              controller: _eventController,
              autofocus: true,
              textAlign: TextAlign.center,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Enter your todo here',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            FlatButton(
              color: Colors.white10,
              onPressed: _addNewTodo,
//                  () {
//                TodoModel todo = TodoModel(title: _title, date: _date);
//                if (widget.todo == null) {
//                  // Insert the task to our user's database
//                  //we set status as 0 meaning we are editing the task, it's incomplete
//                  todo.status = 0;
//                  TodoDBHelper.instance.insertTodo(todo);
//                } else {
//                  // Update the task
//                  todo.id = widget.todo.id;
//                  todo.status = widget.todo.status;
//                  TodoDBHelper.instance.updateTodo(todo);
//                }
//                //updateTaskList is the function we passed, we call it here
//                widget.updateTodoList();
//                Navigator.pop(context);
//
//
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  _handleDatePicker() async {
    //Shows a dialog containing a Material Design _date picker.
    //Type: Future<DateTime> Function
    final DateTime dateOnPicker = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2100),
    );
    if (dateOnPicker != null && dateOnPicker != _calenderDate) {
      setState(() {
        _calenderDate = dateOnPicker;
      }); //DateFormat('MMM dd, yyyy');
      _dateController.text = _dateFormatter.format(dateOnPicker);
//      _selectedDate = date;
    }
  }

  void _addNewTodo() {
    if (_eventController.text.isEmpty) return;
    if (_events[_calendarController.selectedDay] != null) {
      _events[_calendarController.selectedDay].add(_eventController.text);
    } else {
      _events[_calendarController.selectedDay] = [_eventController.text];
    }
    prefs.setString('events', json.encode(encodeMap(_events)));
    Navigator.of(context).pop();
    _eventController.clear();

    print(_events.keys);
    print(_events.values);
    print(_events);

    setState(() {
      _selectedEvents = _events[_calendarController.selectedDay];
    });

//    TodoModel todo = TodoModel(titleList: _title);
//
//    if (todo == null) {
//      // Insert the task to our user's database
//      //we set status as 0 meaning we are editing the task, it's incomplete
//      todo.status = 0;
//      TodoDBHelper.instance.insertTodo(todo);
//    } else {
//      // Update the task
//      todo.id = todo.id;
//      todo.status = todo.status;
//      TodoDBHelper.instance.updateTodo(todo);
//    }
//    //updateTaskList is the function we passed, we call it here
//    _updateTodoList();
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
//            appBar: AppBar(
//              leading: IconButton(
//                icon: Icon(Icons.arrow_back_ios),
//                iconSize: 40,
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              ),
//              title: Text(
//                'iTodo',
//                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700),
//              ),
//              centerTitle: true,
//              elevation: 0,
//              backgroundColor: Colors.transparent,
//            ),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: isDark(context) ? darkSurface : lightSurface,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: _buildTableCalendarWithBuilders()),
                  _buildEventList(),
//    final List<TodoModel> todoList = [];
//    mapsList.forEach((map) {
//    todoList.add(TodoModel.fromMap(map));
//    });
//    todoList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
//    //this return type is TASK
//    return todoList;

//                  Expanded(
//                    child: Container(
//                      width: double.infinity,
//                      margin: EdgeInsets.only(left: 8.0, right: 8, top: 10),
//                      decoration: BoxDecoration(
//                        color: isDark(context) ? darkSurface : lightSurface,
//
////                        color: Colors.white10,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(25.0),
//                            topRight: Radius.circular(25.0)),
//                      ),
//                      child: FutureBuilder(
//                        future: _todoList,
//                        builder: (context, snapshot) {
//                          //if not data
//                          if (!snapshot.hasData) {
//                            return Center(
//                              child: CircularProgressIndicator(),
//                            );
//                          }
//
//                          final int completedTaskCount = snapshot.data
//                              .where((TodoModel todo) => todo.status == 1)
//                              .toList()
//                              .length;
//
//                          if (snapshot.hasData) {
//                            return ListView.builder(
//                                itemCount: snapshot.data.length + 1,
//                                itemBuilder: (BuildContext context, int index) {
//                                  if (index == 0) {
//                                    return Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Text(
//                                        '$completedTaskCount of ${snapshot.data.length}',
//                                        style: TextStyle(
//                                          fontSize: 25.0,
//                                          fontWeight: FontWeight.w600,
//                                        ),
//                                      ),
//                                    );
//                                  }
//
//                                  return TodoCard(
//                                    todo: snapshot.data[index - 1],
//                                    onChangedCallBack: _onChangedCallBack,
//                                    onLongPressCallBack: _onLongPressCallBack,
//                                    onTapCallBack: _onTapCallBack,
//                                  );
//                                });
//                          }
//
//                          return Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 15.0, right: 15, top: 30),
//                              child: Text(
//                                'Add your todo here!',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontSize: 25.0,
//                                  fontWeight: FontWeight.bold,
//                                  fontStyle: FontStyle.italic,
//                                ),
//                              ));
//                        },
//                      ),
//                    ),
//                  ),
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
                      onPressed: _showBottomSheet,
//                        _fabCallBack;
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialSelectedDay: _calenderDate,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide, //?
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all, //?
      calendarStyle: CalendarStyle(
        markersColor: Colors.purple,
        canEventMarkersOverflow: true,
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.orange[300]),
        holidayStyle: TextStyle().copyWith(color: Colors.green[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.orange[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20.0),
        ),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[300],
                borderRadius: BorderRadius.circular(50.0),
              ),
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
//              width: 100,
//              height: 100,
              child: Center(
                child: Text(
                  '${date.day}',
                  style:
                      TextStyle(color: Colors.white).copyWith(fontSize: 25.0),
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.amber[400],
              borderRadius: BorderRadius.circular(50.0),
            ),
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
//            width: 100,
//            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(color: Colors.purple).copyWith(fontSize: 25.0),
              ),
            ),
          );
        },
      ),
      //Type: void Function(DateTime, List<dynamic>)
      onDaySelected: (date, events) {
        setState(() {
          _selectedEvents = events;
          _initialDate = date;
          _animationController.forward(from: 0.0);
        });
      },
      onDayLongPressed: (date, events) {
        _showAddDialog();
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: Container(
        child: ListView(
          shrinkWrap: true, //?
          controller: widget.scrollController,
//          physics: BouncingScrollPhysics(),//?
          children: _selectedEvents
              .map((event) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      title: Text(event.toString()),
                      onTap: () => print('$event tapped!'),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_events[_calendarController.selectedDay] != null) {
                      _events[_calendarController.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_calendarController.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      _selectedEvents = _events[_calendarController.selectedDay];
    });
  }

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
