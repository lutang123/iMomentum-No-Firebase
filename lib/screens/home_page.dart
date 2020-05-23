import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:iMomentum/screens/pomodoro.dart';
//import 'package:iMomentum/screens/meditate.dart';
import 'todo_page.dart';
import 'notes.dart';
import 'package:iMomentum/my_class/greeting.dart';

class HomePage extends StatefulWidget {
  HomePage({this.locationWeather, this.quote});
  final locationWeather;
  final quote;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temperature;
  String cityName;
  String weatherIcon;

  String dailyQuote;
  String author;

  final String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  bool boolVisibleTitle = true;
  bool boolVisibleToday = false;
  bool boolVisibleInput = true;
  bool boolVisibleTodo = false;
  String newFocus = '';

  bool isChecked = false;

  final TextEditingController _textController = TextEditingController();

//  int _currentIndex = 0;
//  void onTabTapped(int index) {
//    setState(() {
//      _currentIndex = index;
//    });
//  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather, widget.quote);
  }

  void updateUI(dynamic weatherData, dynamic quoteData) {
    setState(() {
      if (weatherData == null) {
        weatherIcon = '';
        temperature = 0;
        cityName = '';
        dailyQuote = '';
        author = '';
        return;
      }
      weatherIcon = weatherData['weather'][0]['icon'];
      temperature = weatherData['main']['temp'].toInt();
      cityName = weatherData['name'];
      dailyQuote = quoteData['quote'];
//      dailyQuote = quoteData['body'];
      author = quoteData['author'];
    });
  }

  void _editTextField() {
    setState(() {
      boolVisibleInput = true;
      boolVisibleTodo = false;
      boolVisibleTitle = true;
      boolVisibleToday = false;
    });
    //add this to make keyboard disappear
    FocusScope.of(context).unfocus();
  }

  //is this necessary??
  @override
  void dispose() {
    super.dispose();
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //add this to make keyboard disappear
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage('https://source.unsplash.com/random?nature'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.6), BlendMode.dstATop),
                ),
              ),
              constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (context) => Drawer(),
//                                  ),
//                                );
                              },
                              tooltip: 'menus',
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Image(
                                    image: NetworkImage(
                                        "https://openweathermap.org/img/wn/" +
                                            weatherIcon +
                                            "@2x.png"),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  '$temperature°',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ]),
                              Text(
                                cityName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ), //top search and weather
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formattedTime,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Flexible(
                              child: Text(
                                Greeting().showGreeting(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Visibility(
                              visible: boolVisibleTitle,
                              child: Text(
                                'What is your main focus today?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: boolVisibleToday,
                              child: Text(
                                'Today',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Visibility(
                              visible: boolVisibleInput,
                              child: Container(
                                width: 250,
                                child: TextField(
                                  style: TextStyle(fontSize: 30.0),
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  onSubmitted: (newText) {
                                    if (newText.isNotEmpty) {
                                      setState(() {
                                        newFocus = newText;
                                        boolVisibleTitle = false;
                                        boolVisibleToday = true;
                                        boolVisibleInput = false;
                                        boolVisibleTodo = true;
                                      });
                                      //add this to make keyboard disappear
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Visibility(
                              visible: boolVisibleTodo,
                              child: ListTile(
                                onTap: _editTextField,
                                title: Text(
                                  newFocus,
                                  //also need to wrap in a container and then in a flexible?
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                  ),
                                ),
//                                  trailing: Checkbox(
//                                    activeColor: Colors.lightBlueAccent,
//                                    value: isChecked,
//                                    onChanged: (value) {
//                                      setState(() {
//                                        isChecked = value;
//                                      });
//                                    },
//                                  ),
                              ),
                            ),
                            //daily quote
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '"$dailyQuote"',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
//                            Expanded(
//                              child: SizedBox(
//                                height: 10,
//                              ),
//                            )
                            ],
                          ),
                        ),
                      ),
                      //middle main focus
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              //we can remove this one too as we have set in main.dart
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                //fixedColor and selectedItemColor can only have one.
//                fixedColor: Colors.white,
                selectedItemColor: Colors.white70,
                type: BottomNavigationBarType.fixed,
//                onTap: onTabTapped, // new
//                currentIndex: _currentIndex, // new
                items: [
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                        child: FaIcon(FontAwesomeIcons.stickyNote),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Notes()));
                        }),
                    title: Text(
                      'Notes',
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.smile),
                    title: Text('Meditate'),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.clock),
                    title: Text('Pomodoro'),
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                        child: FaIcon(FontAwesomeIcons.calendarAlt),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Todo()));
                        }),
                    title: Text('Todo'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
