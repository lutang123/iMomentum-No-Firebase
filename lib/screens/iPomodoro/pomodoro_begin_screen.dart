import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iMomentum/screens/iMeditate/constants/theme.dart';
import 'package:iMomentum/screens/iMeditate/widgets/settings_card.dart';
import 'package:iMomentum/customized_widgets/customized_bottom_sheet.dart';
import 'package:iMomentum/screens/iPomodoro/pomodoro_screen.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:iMomentum/screens/iMeditate/constants/preset_timers.dart';

class PomodoroBeginScreen extends StatefulWidget {
  @override
  _PomodoroBeginScreenState createState() => _PomodoroBeginScreenState();
}

class _PomodoroBeginScreenState extends State<PomodoroBeginScreen> {
  Duration _duration = pomodoroTimers[0];
  bool _playSounds = false;

  @override
  Widget build(BuildContext context) {
    return CustomizedBottomSheet(
      child: Container(
        child: Column(
          mainAxisAlignment: cupertino.MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Stay Focused',
              style: Theme.of(context).textTheme.headline4,
            ),
            cupertino.SizedBox(height: 10),
            SettingsCard(
              start: true,
              title: Text(
                'Duration',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              leading: Icon(Ionicons.ios_hourglass),
              trailing: DropdownButton<Duration>(
                underline: Container(),
                items: pomodoroTimers.map((preset) {
                  return DropdownMenuItem<Duration>(
                    value: preset,
                    child: Text(
                      '${preset.inMinutes} minutes',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  );
                }).toList(),
                value: _duration,
                onChanged: (value) {
                  setState(() {
//                    Provider.of<MeditationModel>(context, listen: false)
//                        .duration = value;
                    _duration = value;
                  });
                },
              ),
            ),
            SettingsCard(
              title: Text(
                'Play sound',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              leading: Icon(Ionicons.ios_musical_note),
              trailing: cupertino.CupertinoSwitch(
                activeColor: accent,
                onChanged: (value) {
                  setState(() {
                    _playSounds = value;
//                    Provider.of<MeditationModel>(context, listen: false)
//                        .playSounds = value;
                  });
                },
//                value: Provider.of<MeditationModel>(context).playSounds,
                value: _playSounds,
              ),
            ),
            cupertino.SizedBox(height: 20),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(68.0),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => PomodoroScreen(
                    duration: _duration,
                    playSounds: _playSounds,
                  ),
                );
              },
              child: Text(
                'BEGIN',
                style: GoogleFonts.varelaRound(
                  color: fgDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ).padding(all: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}

//import 'dart:io';
//
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
//import '../../constants.dart';
//
//class Pomodoro extends StatefulWidget {
//  @override
//  _PomodoroState createState() => _PomodoroState();
//}
//
//class _PomodoroState extends State<Pomodoro> {
//  //'https://source.unsplash.com/random?nature'
//
//  String homePageImageURL;
//
//  void updateImage() {
//    setState(() {
//      try {
//        homePageImageURL = Constants.homePageImage;
//      } on SocketException catch (_) {}
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        children: <Widget>[
////          Container(
////            child: CachedNetworkImage(
////              imageUrl: homePageImageURL,
////              fit: BoxFit.cover,
////              imageBuilder: (context, imageProvider) => Container(
////                decoration: BoxDecoration(
////                  image: DecorationImage(
////                      image: imageProvider,
////                      fit: BoxFit.cover,
////                      colorFilter: ColorFilter.mode(
////                          Colors.white.withOpacity(0.8), BlendMode.dstATop)
//////                    colorFilter: ColorFilter.mode(
//////                        Colors.transparent, BlendMode.colorBurn),
////                      ),
////                ),
////              ),
////              placeholder: (context, url) =>
////                  Center(child: CircularProgressIndicator()),
////              errorWidget: (context, url, error) => Container(
////                decoration: BoxDecoration(
////                  image: DecorationImage(
////                    image: AssetImage('images/other_page.jpg'),
////                    fit: BoxFit.cover,
////                    colorFilter: ColorFilter.mode(
////                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
////                  ),
////                ),
////              ),
////            ),
////          ),
//          Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: CachedNetworkImageProvider(
//                    'https://source.unsplash.com/random?nature'),
//                fit: BoxFit.cover,
//                colorFilter: ColorFilter.mode(
//                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
//              ),
//            ),
//            constraints: BoxConstraints.expand(),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                FlatButton(
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                  child: FaIcon(FontAwesomeIcons.arrowLeft, size: 40.0),
//                ),
//              ],
//            ),
//          ),
////          Align(
////              alignment: Alignment.bottomCenter,
////              child: Row(
////                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////                children: <Widget>[
////                  IconButton(
////                    icon: Icon(
////                      Icons.home,
////                      color: Colors.white,
////                    ),
////                    onPressed: () {},
////                  ),
////                  IconButton(
////                    icon: Icon(
////                      Icons.home,
////                      color: Colors.white,
////                    ),
////                    onPressed: () {},
////                  ),
////                  IconButton(
////                    icon: Icon(
////                      Icons.home,
////                      color: Colors.white,
////                    ),
////                    onPressed: () {},
////                  ),
////                ],
////              )),
//        ],
//      ),
//    );
//  }
//}
//
////class Quote extends StatelessWidget {
////  @override
////  Widget build(BuildContext context) {
////    return FutureBuilder(
////        future: _getQuote(),
////        builder: (context, snapshot) {
////          return snapshot.connectionState == ConnectionState.done
////              ? Center(
////                  child: Text(
////                  snapshot.data,
////                  textAlign: TextAlign.center,
////                ))
////              : Center(child: CircularProgressIndicator());
////        });
////  }
////}
//
////http://quotes.rest/qod.json?category=inspire
//
////https://blog.api.rakuten.net/top-10-best-quotes-apis-quotes-api-random-quotes-api-quote-of-the-day-api-and-others/
//
////https://medium.com/flutter-community/create-a-motivation-app-using-flutter-391de123a382
