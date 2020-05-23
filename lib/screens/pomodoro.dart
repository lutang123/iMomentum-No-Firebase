import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/other_page.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: FaIcon(FontAwesomeIcons.arrowLeft, size: 40.0),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

//class Quote extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//        future: _getQuote(),
//        builder: (context, snapshot) {
//          return snapshot.connectionState == ConnectionState.done
//              ? Center(
//                  child: Text(
//                  snapshot.data,
//                  textAlign: TextAlign.center,
//                ))
//              : Center(child: CircularProgressIndicator());
//        });
//  }
//}

//http://quotes.rest/qod.json?category=inspire

//https://blog.api.rakuten.net/top-10-best-quotes-apis-quotes-api-random-quotes-api-quote-of-the-day-api-and-others/

//https://medium.com/flutter-community/create-a-motivation-app-using-flutter-391de123a382
