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
      theme: ThemeData.dark().copyWith(
        canvasColor: Colors.transparent,
//        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54),
      ),

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
