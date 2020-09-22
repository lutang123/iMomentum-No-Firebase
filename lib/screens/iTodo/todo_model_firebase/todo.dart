import 'package:flutter/foundation.dart';

class Todo {
  Todo({
    @required this.id,
    @required this.dateId,
    @required this.start,
    @required this.end,
    this.content,
  });

  String id;
  String dateId;
  DateTime start;
  DateTime end;
  String content;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Todo.fromMap(Map<dynamic, dynamic> value, String id) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    return Todo(
      id: id,
      dateId: value['dateId'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      content: value['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateId': dateId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'content': content,
    };
  }
}
