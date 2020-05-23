import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iMomentum/network_service/quote_service/fetch_quote.dart';
import 'package:iMomentum/screens/home_page.dart';
import 'package:iMomentum/network_service/weather_service/weather.dart';

class LoadingLocation extends StatefulWidget {
  @override
  _LoadingLocationState createState() => _LoadingLocationState();
}

class _LoadingLocationState extends State<LoadingLocation> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var quote = await FetchQuote().fetchQuote();
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage(locationWeather: weatherData, quote: quote);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/home_page.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
