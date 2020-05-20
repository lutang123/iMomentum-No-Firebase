import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/screens/todos.dart';
import 'calender.dart';
import 'home.dart';
import 'notes.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int _currentIndex = 0;
  List<Widget> _children;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _currentIndex,
          children: _children = [
            HomePage(),
            Calender(),
            Notes(),
            Todo(),
          ]),

//      bottomNavigationBar: BottomNavigationBar(
//        fixedColor: Colors.white,
//        type: BottomNavigationBarType.fixed,
//        onTap: (int index) {
//          setState(() {
//            _currentIndex = index;
//          });
//        }, // new
//        currentIndex: _currentIndex, // new
//        items: [
//          BottomNavigationBarItem(
//            icon: FaIcon(FontAwesomeIcons.user),
//            title: Text(
//              'Me',
//            ),
//          ),
//          BottomNavigationBarItem(
//            icon: FaIcon(FontAwesomeIcons.calendar),
//            title: Text('Note'),
//          ),
//          BottomNavigationBarItem(
//            icon: FaIcon(FontAwesomeIcons.stickyNote),
//            title: Text('Notes'),
//          ),
//          BottomNavigationBarItem(
//            icon: FaIcon(FontAwesomeIcons.list),
//            title: Text('Todo'),
//          ),
//        ],
//      ),
    );
  }
}
