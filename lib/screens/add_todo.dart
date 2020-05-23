import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iMomentum/todo_model/todo_database.dart';
import 'package:iMomentum/todo_model/todo_model.dart';

class AddTodoScreen extends StatefulWidget {
  AddTodoScreen({this.updateTodoList, this.todo});
  final Function updateTodoList;
  final TodoModel todo;

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  String _title;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    //this widget refers to the data we passed from list screen
    if (widget.todo != null) {
      _title = widget.todo.title;
      _date = widget.todo.date;
    }
    //to make sure when we first come to this page the date is shown there
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  _handleDatePicker() async {
    //Shows a dialog containing a Material Design _date picker.
    //Type: Future<DateTime> Function
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date, //we set as DateTime _date = DateTime.now();
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      }); //DateFormat('MMM dd, yyyy');
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.todo == null ? 'Add Task' : 'Update Task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white70),
              ),
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
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _title = value;
                },
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
                onPressed: () {
                  TodoModel todo = TodoModel(title: _title, date: _date);
                  if (widget.todo == null) {
                    // Insert the task to our user's database
                    //we set status as 0 meaning we are editing the task, it's incomplete
                    todo.status = 0;
                    TodoDBHelper.instance.insertTodo(todo);
                  } else {
                    // Update the task
                    todo.id = widget.todo.id;
                    todo.status = widget.todo.status;
                    TodoDBHelper.instance.updateTodo(todo);
                  }
                  //updateTaskList is the function we passed, we call it here
                  widget.updateTodoList();
                  Navigator.pop(context);
                },
                child: Text(widget.todo == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
