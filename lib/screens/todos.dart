import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/other_page.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Text('ToDos'),
        ),
      ),
    );
  }
}

//floatingActionButton: FloatingActionButton(
//backgroundColor: Colors.white,
//child: FaIcon(FontAwesomeIcons.plus),
//onPressed: () {
//Navigator.pushNamed(context, '/notes');
//            showModalBottomSheet(
//                context: context,
//                isScrollControlled: true,
//                builder: (context) => SingleChildScrollView(
//                        child: Container(
//                      padding: EdgeInsets.only(
//                          bottom: MediaQuery.of(context).viewInsets.bottom),
//                      child: AddTaskScreen(),
//                    )));
//}),
//
//import 'package:flutter/material.dart';
////import 'package:provider/provider.dart';
//
//class Todo extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    String newTaskTitle;
//
//    return Container(
//      color: Color(0xff757575),
//      child: Container(
//        padding: EdgeInsets.all(20.0),
//        decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.only(
//            topLeft: Radius.circular(20.0),
//            topRight: Radius.circular(20.0),
//          ),
//        ),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Text(
//              'Add Task',
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontSize: 30.0,
//                color: Colors.lightBlueAccent,
//              ),
//            ),
//            TextField(
//              autofocus: true,
//              textAlign: TextAlign.center,
//              onChanged: (newText) {
//                newTaskTitle = newText;
//                print(newTaskTitle);
//              },
//            ),
//            FlatButton(
//              child: Text(
//                'Add',
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//              color: Colors.lightBlueAccent,
//              onPressed: () {
////                Provider.of<TaskData>(context).addTask(newTaskTitle);
//                Navigator.pop(context);
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
