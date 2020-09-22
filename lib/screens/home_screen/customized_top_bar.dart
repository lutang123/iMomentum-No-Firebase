import 'package:flutter/material.dart';

class CustomizedTopBar extends StatelessWidget {
  const CustomizedTopBar({
    Key key,
    @required this.weatherIcon,
    @required this.temperature,
    @required this.cityName,
  }) : super(key: key);

  final String weatherIcon;
  final int temperature;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('logo',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: NetworkImage("https://openweathermap.org/img/wn/" +
                        weatherIcon +
                        "@2x.png"),
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  '$temperature°',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ]),
              Text(
                cityName,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
