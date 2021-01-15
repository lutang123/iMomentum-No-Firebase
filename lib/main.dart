import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iMomentum/screens/home_screen/home_screen.dart';
import 'package:iMomentum/screens/iMeditate/constants/theme.dart';
import 'package:iMomentum/screens/iMeditate/utils/utils.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  loadLicenses();
  // Ensure services are loaded before the widgets get loaded
  WidgetsFlutterBinding.ensureInitialized();
  // Restrict device orientiation to portraitUp
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    var globalMaterialLocalizations;
//    var globalWidgetsLocalizations;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iMomentum',
//      theme: ThemeData.dark().copyWith(
//        canvasColor: Colors.transparent,
////        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54),
//      ),
//        localizationsDelegates: [
//          S.delegate,
//          globalMaterialLocalizations.delegate,
//          globalWidgetsLocalizations.delegate,
//        ],
//        supportedLocales: S.delegate.supportedLocales,

      builder: (context, widget) {
        return ResponsiveWrapper.builder(
          widget,
//          maxWidth: 1200,
//          minWidth: 450,
          defaultScale: true,
//            breakpoints: [
//              ResponsiveBreakpoint(breakpoint: 450, name: MOBILE),
//              ResponsiveBreakpoint(
//                  breakpoint: 800, name: TABLET, autoScale: true),
//              ResponsiveBreakpoint(
//                  breakpoint: 1000, name: TABLET, autoScale: true),
//              ResponsiveBreakpoint(breakpoint: 1200, name: DESKTOP),
//              ResponsiveBreakpoint(
//                  breakpoint: 2460, name: "4K", autoScale: true),
//            ],
          background: Container(
            color: isDark(context) ? bgDark : fgDark,
          ),
        );
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: HomeScreen(),

//        // ignore: missing_return
//        onGenerateRoute: (settings) {
//          if (settings.name == '/') {
//            return PageRoutes.fade(() => LoadingScreen());
////                MainScreen(startingAnimation: true));
//          }
//        },
    );
  }
}

//import 'package:flutter/material.dart';
//import 'screens/first_loading/loading_screen.dart';
////https://flutter.dev/docs/cookbook/images/fading-in-images
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Note',
//      theme: ThemeData.dark().copyWith(
//        canvasColor: Colors.transparent,
////        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54),
//      ),
//
//      home: LoadingLocation(),
////      routes: {
////        '/': (context) => LoadingLocation(),
////        '/calendar': (context) => Calender(),
////        '/todos': (context) => ToDos(),
////        '/notes': (context) => screens.Notes(),
////      },
//    );
//  }
//}
