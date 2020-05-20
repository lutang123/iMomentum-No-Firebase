import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'calender.dart';
//import 'google.dart';
//import 'todos.dart';
//import 'notes.dart';
//import 'test.dart';

class HomePage extends StatefulWidget {
  HomePage({this.locationWeather, this.quote});
  final locationWeather;
  final quote;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  WeatherModel weatherModel = WeatherModel();

  int temperature;
  String cityName;
  String weatherIcon;

  String dailyQuote;
  String author;

  final String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  String newFocus = '';
  bool boolVisibleInput = true;
  bool boolVisibleTodo = false;

//  final TextEditingController _controllerFocus = TextEditingController();

  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
      author = quoteData['author'];
    });
  }

  void _editNewFocus() {
    setState(() {
      boolVisibleInput = true;
      boolVisibleTodo = false;
    });
  }

//  //is this necessary??
//  @override
//  void dispose() {
//    super.dispose();
//    // Clean up the controller when the widget is removed from the widget tree.
//    // This also removes the _printLatestValue listener.
//    _controllerFocus.dispose();
//  }

//  List<Widget> _children;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      body: IndexedStack(
//          index: _currentIndex,
//          children: _children = [
//            HomePage(),
//            Calender(),
//            Notes(),
//            Todos(),
//          ]),

      body: Stack(
        children: <Widget>[
          Container(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                            tooltip: 'Likes',
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
                      ),
                    ), //top search and weather
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 60),
                      child: Column(
                        children: [
                          Text(
                            formattedTime,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25.0),
                          Text(
                            'What is your main focus today?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
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
                                  setState(() {
                                    newFocus = newText;
                                    boolVisibleInput = false;
                                    boolVisibleTodo = true;
                                  });
//                            boolVisiblePlus = true;
                                },
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
//                            suffixIcon: Visibility(
//                              visible: boolVisiblePlus,
//                              child: IconButton(
//                                icon: FaIcon(FontAwesomeIcons.plus),
//                                color: Colors.white,
//                                iconSize: 30,
//                                onPressed: _submitNewFocus,
//                                tooltip: 'Plus',
//                              ),
//                            ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Visibility(
                            visible: boolVisibleTodo,
                            child: GestureDetector(
                              onTap: _editNewFocus,
                              child: Text(
                                newFocus,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
//                          Checkbox(
//                            activeColor: Colors.lightBlueAccent,
//                            value: isChecked,
//                            onChanged: (value) {
//                              setState(() {
//                                isChecked = value;
//                              });
//                            },
//                          ),
                            ),
                          ),
                        ],
                      ),
                    ), //middle main focus
                    //Todo tap to pop up to read all and like or share.
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, top: 130, bottom: 20),
                      child: Flexible(
                        child: Container(
                          child: Text(
                            "$dailyQuote" '--$author',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ), //daily quote
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                fixedColor: Colors.white,
                selectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                onTap: onTabTapped, // new
                currentIndex: _currentIndex, // new
                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.smile),
                    title: Text(
                      'Me',
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.calendar),
                    title: Text('Note'),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.stickyNote),
                    title: Text('Notes'),
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                        child: FaIcon(FontAwesomeIcons.list),
                        onTap: () {
//                          Navigator.push(context,
//                              MaterialPageRoute(builder: (context) => Test()));
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
