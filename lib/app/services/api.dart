import 'package:flutter/foundation.dart';

import 'api_keys.dart';

final scheme = 'https';

final pathToken = 'token';

final pathCases = 'cases';
final pathCasesSuspected = 'cases/suspected';
final pathCasesConfirmed = 'cases/confirmed';
final pathDeaths = 'deaths';
final pathRecovered = 'recovered';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;

  API({@required this.apiKey});

  static final String host = "apigw.nubentos.com";
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi/1.0.0';

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  Uri tokenUri() => Uri(
        scheme: scheme,
        host: host,
        port: port,
        path: pathToken,
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: scheme,
        host: host,
        port: port,
        path: '$basePath/${_paths[endpoint]}',
  );

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: pathCases,
    Endpoint.casesSuspected: pathCasesSuspected,
    Endpoint.casesConfirmed: pathCasesConfirmed,
    Endpoint.deaths: pathDeaths,
    Endpoint.recovered: pathRecovered,
  };
}
