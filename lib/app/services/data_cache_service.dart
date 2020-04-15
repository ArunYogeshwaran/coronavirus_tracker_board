import 'package:coronavirus_tracker_board/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker_board/app/services/api.dart';
import 'package:coronavirus_tracker_board/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String countValueKey(Endpoint endpoint) => '$endpoint/count';
  static String dateValueKey(Endpoint endpoint) => '$endpoint/date';

  EndpointsData getData() {
    Map<Endpoint, EndpointData> values = {};
    Endpoint.values.forEach((endpoint) { 
      final count = sharedPreferences.getInt(countValueKey(endpoint));
      final dateString = sharedPreferences.getString(dateValueKey(endpoint));
      if (count != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(count: count, date: date);
      }
    });
    return EndpointsData(values: values);
  }

  setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointsData) async {
      await sharedPreferences.setInt(
        countValueKey(endpoint),
        endpointsData.count,
      );
      await sharedPreferences.setString(
        dateValueKey(endpoint),
        endpointsData.date.toIso8601String(),
      );
    });
  }
}
