import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iMomentum/customized_widgets/customized_bottom_sheet.dart';
import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:iMomentum/screens/iMeditate/constants/quotes_data.dart';
import 'package:iMomentum/screens/iMeditate/constants/theme.dart';
import 'package:iMomentum/screens/iMeditate/utils/extensions.dart';
import 'package:iMomentum/screens/iMeditate/utils/utils.dart';
import 'package:iMomentum/screens/iMeditate/widgets/countdown_circle.dart';

class PomodoroScreen extends StatefulWidget {
  PomodoroScreen({this.duration, this.playSounds});
  final Duration duration;
  final bool playSounds;

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  Stopwatch _stopwatch;
  Timer _timer;

  // Keeps track of how much time has elapsed
  Duration _duration;
  // This string that is displayed as the countdown timer
  String _display = 'Be at peace';

  bool visibleDONE = false;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _playSound();
    _duration = widget.duration;
    _stopwatch = Stopwatch();

    _start();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.forward().orCancel;

//    _controller.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        Navigator.pop(context);
//        print('completed');
////        setState(() {
////          visibleMeditate = !visibleMeditate;
////          visibleComplete = !visibleComplete;
////        });
//      }
//    });
  }

  // Play a sound
  void _playSound() {
    if (widget.playSounds) {
      final assetsAudioPlayer = AssetsAudioPlayer();
      assetsAudioPlayer.open(
        Audio("images/gong.mp3"),
        autoStart: true,
      );
    }
  }

  // This will start the Timer
  void _start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
    if (_timer != null) {
      if (_timer.isActive) return;
    }
    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer t) {
      // update display
      setState(() {
        var diff = (_duration - _stopwatch.elapsed);
        _display = diff.clockFmt();
        if (diff.inMilliseconds <= 0) {
          _playSound();
          stop(cancelled: false);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _stopwatch.stop();
    _controller.dispose();
  }

  // This will pause the timer
  void pause() {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _stopwatch.stop();
    });
  }

  // This will stop the timer
//  void stop({bool cancelled = true}) {
  void stop({bool cancelled = true}) {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _timer.cancel();
      _stopwatch.stop();
    });

    if (cancelled) {
      Navigator.pop(context);
    } else {
      setState(() {
        visibleDONE = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomizedBottomSheet(
      child: Column(
        children: <Widget>[
          Container(
            height: (size.height / 5) * 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
//                              SizedBox.expand( //doesn't matter
//                                child:
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: CustomPaint(
                          painter: CircleCountdownPainter(
                            thinRing:
                                Theme.of(context).accentColor.withOpacity(0.85),
                            tickerRing: Theme.of(context).accentColor,
                            animation: Tween<double>(begin: 0.0, end: pi * 2)
                                .animate(CurvedAnimation(
                                    parent: _controller, curve: Curves.linear)),
                          ),
                        ),
                      ),

                      Container(
                        child: Text(
                          _display,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: visibleDONE,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Theme.of(context).disabledColor,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'DONE',
                      style: GoogleFonts.varelaRound(
                        color: Color(0xFF707073),
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
