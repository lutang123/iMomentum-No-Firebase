import 'package:flutter/material.dart';
import 'screens/loading.dart';
//https://flutter.dev/docs/cookbook/images/fading-in-images

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note',
      theme: ThemeData.dark(),
//      ThemeData(
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
      home: LoadingLocation(),
//      routes: {
//        '/': (context) => LoadingLocation(),
//        '/calendar': (context) => Calender(),
//        '/todos': (context) => ToDos(),
//        '/notes': (context) => Notes(),
//      },
    );
  }
}
