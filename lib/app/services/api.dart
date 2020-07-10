import 'package:flutter/foundation.dart';

import 'api_keys.dart';

final scheme = 'https';

final pathToken = 'token';

final pathCases = 'cases';
final pathCasesSuspected = 'casesSuspected';
final pathCasesConfirmed = 'casesConfirmed';
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

  static final String host = "ncov2019-admin.firebaseapp.com";
  static final int port = 443;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  Uri tokenUri() => Uri(
        scheme: scheme,
        host: host,
        port: port,
        path: pathToken
      );

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: scheme,
        host: host,
        port: port,
        path: '${_paths[endpoint]}',
  );

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: pathCases,
    Endpoint.casesSuspected: pathCasesSuspected,
    Endpoint.casesConfirmed: pathCasesConfirmed,
    Endpoint.deaths: pathDeaths,
    Endpoint.recovered: pathRecovered,
  };
}
