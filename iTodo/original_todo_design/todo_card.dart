import 'package:flutter/material.dart';
import 'package:iMomentum/screens/iTodo/todo_screen/todo_model/todo_model.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  TodoCard(
      {this.todo,
      this.onChangedCallBack,
      this.onLongPressCallBack,
      this.onTapCallBack});
  final TodoModel todo;
  final Function onChangedCallBack;
  final Function onLongPressCallBack;
  final Function onTapCallBack;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
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
            onChangedCallBack(newValue, todo);
          },
        ),
        onLongPress: () {
          onLongPressCallBack(todo);
        },
        onTap: () {
          onTapCallBack(todo);
        },
      ),
    );
  }
}
