import 'package:intl/intl.dart';

class Greeting {
  final int hour = int.parse(DateFormat('kk').format(DateTime.now()));
  String greeting;
  String showGreeting() {
    if ((hour > 4) & (hour <= 9)) {
      greeting = 'Good Morning. Live in the moment.';
    } else if ((hour > 9) & (hour <= 12)) {
      greeting = 'You are capable of wonderful things.';
    } else if ((hour > 12) & (hour <= 1)) {
      greeting = 'Breathe';
    } else if ((hour > 1) & (hour <= 2)) {
      greeting = 'Be kind to yourself.';
    } else if ((hour > 2) & (hour <= 3)) {
      greeting = 'Good afternoon. Be present.';
    } else if ((hour > 3) & (hour <= 5)) {
      greeting = 'Good afternoon. You matter.';
    } else if ((hour > 5) & (hour <= 7)) {
      greeting = 'Fear less, love more.';
    } else if ((hour > 7) & (hour <= 9)) {
      greeting = 'Good evening. Trust yourself.';
    } else if ((hour > 9) & (hour <= 4)) {
      greeting = 'Do more of what makes you happy.';
    } else {
      greeting = 'Stay positive.';
    }
    return greeting;
  }
}
