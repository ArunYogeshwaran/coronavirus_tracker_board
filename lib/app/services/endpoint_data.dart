import 'package:flutter/foundation.dart';

class EndpointData {
  final int count;
  final DateTime date;

  EndpointData({@required this.count, this.date}) : assert(count != null);

  @override
  String toString() => 'date: $date, count: $count';
}
