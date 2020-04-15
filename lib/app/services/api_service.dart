import 'dart:convert';

import 'package:coronavirus_tracker_board/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';
import 'package:http/http.dart' as http;

final Api_Authorization = 'Authorization';
final Api_Authorization_Basic = 'Basic';
final Api_Authorization_Bearer = 'Bearer';
final Api_Access_Token = 'access_token';

final responeKeyData = 'data';
final responeKeyCases = 'cases';

class APIService {
  final API api;

  APIService(this.api);

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {Api_Authorization: 'Api_Authorization_Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data[Api_Access_Token];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndpointData> getEndpointData(
      {@required String accessToken, 
      @required Endpoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {Api_Authorization: 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final responseJsonKey = _responseJsonKeys[endpoint];
        final int count = endpointData[responseJsonKey];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);
        if (count != null) {
          return EndpointData(count: count, date: date);
        }
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: responeKeyCases,
    Endpoint.casesSuspected: responeKeyData,
    Endpoint.casesConfirmed: responeKeyData,
    Endpoint.deaths: responeKeyData,
    Endpoint.recovered: responeKeyData,
  };
}
