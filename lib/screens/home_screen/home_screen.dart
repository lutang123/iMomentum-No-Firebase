import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iMomentum/constants.dart';
import 'package:iMomentum/network_service/quote_service/fetch_quote.dart';
import 'package:iMomentum/network_service/weather_service/weather.dart';
import 'package:intl/intl.dart';
import '../../customized_widgets/customized_bottom_bar.dart';
import 'greeting.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
//  HomePage({this.locationWeather, this.quote});
//  final locationWeather;
//  final quote;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  String homePageImageURL;
  int temperature;
  String cityName;
  String weatherIcon;
  String dailyQuote;

//  final String formattedTime = DateFormat('kk:mm').format(DateTime.now());

  final String formattedDate = DateFormat.yMMMd().format(DateTime.now());

  bool boolVisibleTitle = true;
  bool boolVisibleToday = false;
  bool boolVisibleInput = true;
  bool boolVisibleTodo = false;
  bool visibleDate = true;
  bool visibleGreeting = false;
  String newFocus = '';

  @override
  void initState() {
    super.initState();
    getData();
//    fetchWeatherAndQuote(widget.locationWeather, widget.quote);
//    updateImage();
  }

  void getData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var quote = await FetchQuote().fetchQuote();
    setState(() {
      if (weatherData == null) {
        weatherIcon = '';
        temperature = 0;
        cityName = 'Unknown';
        return;
      }
      if (quote == null) {
        dailyQuote =
            '“The world breaks everyone and afterward many are strong at the broken places.” --Ernest Hemingway';
        return;
      }
      weatherIcon = weatherData['weather'][0]['icon'];
      temperature = weatherData['main']['temp'].toInt();
      cityName = weatherData['name'];
      dailyQuote = quote['quote'];
    });
  }

//  void fetchWeatherAndQuote(dynamic weatherData, dynamic quoteData) {
//    setState(() {
//      if (weatherData == null) {
//        weatherIcon = '';
//        temperature = 0;
//        cityName = 'Unknown';
//        dailyQuote = '“The world breaks everyone and afterward many are strong at the broken places.” --Ernest Hemingway';
//        return;
//      }
//      weatherIcon = weatherData['weather'][0]['icon'];
//      temperature = weatherData['main']['temp'].toInt();
//      cityName = weatherData['name'];
//      dailyQuote = quoteData['quote'];
//    });
//  }

  void _editTextField() {
    setState(() {
      boolVisibleInput = true;
      boolVisibleTodo = false;
      boolVisibleTitle = true;
      boolVisibleToday = false;
      visibleDate = false;
      visibleGreeting = true;
    });
    //add this to make keyboard disappear
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(Constants.homePageImage, fit: BoxFit.cover),
        //TODO update LinearGradient
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
        GestureDetector(
          onTap: () {
            //add this to make keyboard disappear
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              top: false,
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, bottom: 8, top: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('logo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(children: [
//                                  Container(
//                                    height: 40,
//                                    width: 40,
//                                    child: Image(
//                                      image: NetworkImage(
//                                          "https://openweathermap.org/img/wn/" +
//                                              weatherIcon +
//                                              "@2x.png"),
//                                    ),
//                                  ),
                                SizedBox(width: 5.0),
                                Text(
                                  '$temperature°',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ]),
                              Text(
                                'Vancouver',
//                                  cityName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
//                      CustomizedTopBar(
//                          weatherIcon: weatherIcon,
//                          temperature: temperature,
//                          cityName: cityName),
                  //top search and weather
                  //TODO: Flexible or Expanded???
                  Expanded(
                    flex: 16,
                    child: Column(
                      //TODO: ???
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
//                            SizedBox(height: 25.0),

                        Visibility(
                          visible: visibleDate,
                          child: Text(
                            formattedDate,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Visibility(
                          visible: boolVisibleTitle,
                          child: TypewriterAnimatedTextKit(
                            isRepeatingAnimation: false,
                            totalRepeatCount: 1,
                            speed: Duration(milliseconds: 100),
                            text: ['What is your main focus today?'],
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                          visible: boolVisibleToday,
                          child: Text(
                            'Today',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Visibility(
                          visible: visibleGreeting,
                          child: Flexible(
                            child: AutoSizeText(
                              Greeting().showGreeting(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Visibility(
                          visible: boolVisibleInput,
                          child: Container(
                            width: 280,
                            child: TextField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
//                              autofocus: true,
                              textAlign: TextAlign.center,
                              onSubmitted: (newText) {
                                if (newText.isNotEmpty) {
                                  setState(() {
                                    newFocus = newText;
                                    boolVisibleTitle = false;
                                    boolVisibleToday = true;
                                    boolVisibleInput = false;
                                    boolVisibleTodo = true;
                                    visibleDate = false;
                                    visibleGreeting = true;
                                  });
                                  //add this to make keyboard disappear
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              cursorColor: Colors.white,
//                                  maxLength: 50,
//                                keyboardType: TextInputType.multiline,
//                                  maxLines: 2,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Visibility(
                          visible: boolVisibleTodo,
                          child: ListTile(
                            onTap: _editTextField,
                            title: AutoSizeText(
                              newFocus,
                              //also need to wrap in a container and then in a flexible?
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              minFontSize: 18,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                        ),
                        //daily quote
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: AutoSizeText(
                            '"$dailyQuote"',
//                                overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomizedBottomBar(),
                  //middle main focus
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//
//      Scaffold(
//      body: Stack(
//        children: <Widget>[
//          GestureDetector(
//            onTap: () {
//              //add this to make keyboard disappear
//              FocusScope.of(context).unfocus();
//            },
//            child: Container(
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  image: NetworkImage(Constants.homePageImage),
//                  fit: BoxFit.cover,
//                  colorFilter: ColorFilter.mode(
//                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
//                ),
//              ),
//              //TODO: what's this mean?
//              constraints: BoxConstraints.expand(),
//              child: SafeArea(
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  //TODO: wrap whole Column??
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
//                          Align(
//                            alignment: Alignment.topLeft,
//                            child: IconButton(
//                              icon: Icon(Icons.settings),
//                              onPressed: () {},
//                              tooltip: 'menus',
//                            ),
//                          ),
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.end,
//                            children: [
//                              Row(children: [
//                                Container(
//                                  height: 40,
//                                  width: 40,
//                                  child: Image(
//                                    image: NetworkImage(
//                                        "https://openweathermap.org/img/wn/" +
//                                            weatherIcon +
//                                            "@2x.png"),
//                                  ),
//                                ),
//                                SizedBox(width: 5.0),
//                                Text(
//                                  '$temperature°',
//                                  style: TextStyle(
//                                    fontSize: 20.0,
//                                  ),
//                                ),
//                              ]),
//                              Text(
//                                cityName,
//                                style: TextStyle(
//                                  fontSize: 20.0,
//                                ),
//                              ),
//                            ],
//                          )
//                        ],
//                      ), //top search and weather
//                      //TODO: Flexible or Expanded???
//                      Flexible(
//                        fit: FlexFit.loose, //??
//                        flex: 5,
//                        child: Column(
//                          //TODO: ???
//                          mainAxisSize: MainAxisSize.min,
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Text(
//                              formattedTime,
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                fontSize: 50.0,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
//                            SizedBox(height: 15.0),
//                            Flexible(
//                              child: Text(
//                                Greeting().showGreeting(),
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontSize: 35.0,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 25.0),
//                            Visibility(
//                              visible: boolVisibleTitle,
//                              child: Text(
//                                'What is your main focus today?',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontSize: 30.0,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                            ),
//                            Visibility(
//                              visible: boolVisibleToday,
//                              child: Text(
//                                'Today',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  fontSize: 30.0,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 15.0),
//                            Visibility(
//                              visible: boolVisibleInput,
//                              child: Container(
//                                width: 250,
//                                child: TextField(
//                                  style: TextStyle(fontSize: 30.0),
//                                  autofocus: true,
//                                  textAlign: TextAlign.center,
//                                  onSubmitted: (newText) {
//                                    if (newText.isNotEmpty) {
//                                      setState(() {
//                                        newFocus = newText;
//                                        boolVisibleTitle = false;
//                                        boolVisibleToday = true;
//                                        boolVisibleInput = false;
//                                        boolVisibleTodo = true;
//                                      });
//                                      //add this to make keyboard disappear
//                                      FocusScope.of(context).unfocus();
//                                    }
//                                  },
//                                  cursorColor: Colors.white,
//                                  decoration: InputDecoration(
//                                    focusedBorder: UnderlineInputBorder(
//                                      borderSide:
//                                          BorderSide(color: Colors.white),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                            SizedBox(height: 15),
//                            Visibility(
//                              visible: boolVisibleTodo,
//                              child: ListTile(
//                                onTap: _editTextField,
//                                title: Text(
//                                  newFocus,
//                                  //also need to wrap in a container and then in a flexible?
//                                  overflow: TextOverflow.ellipsis,
//                                  maxLines: 3,
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                    fontSize: 25.0,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            //daily quote
//                          ],
//                        ),
//                      ),
//                      Flexible(
//                        child: Align(
//                          alignment: Alignment.bottomCenter,
//                          child: Column(
//                            children: <Widget>[
//                              Text(
//                                '"$dailyQuote"',
//                                overflow: TextOverflow.ellipsis,
//                                maxLines: 3,
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: 15,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                      //middle main focus
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: Theme(
//              //we can remove this one too as we have set in main.dart
//              data: Theme.of(context).copyWith(
//                canvasColor: Colors.transparent,
//              ),
//              child: ButtomBar(),
//            ),
//          ),
//        ],
//      ),
//    );
