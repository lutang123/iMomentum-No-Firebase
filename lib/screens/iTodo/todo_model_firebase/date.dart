import 'dart:ui';

import 'package:meta/meta.dart';

class Date {
  Date({@required this.id, @required this.date});
  final String id;
  final String date;

  factory Date.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }

    return Date(id: documentId, date: name);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': date,
    };
  }

  @override
  int get hashCode => hashValues(id, date);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Date otherJob = other;
    return id == otherJob.id && date == otherJob.date;
  }

  @override
  String toString() => 'id: $id, name: $date';
}
