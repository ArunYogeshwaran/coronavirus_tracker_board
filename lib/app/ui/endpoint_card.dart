import 'package:coronavirus_tracker_board/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int count;
  EndpointCard({Key key, this.endpoint, this.count});

  static Map<Endpoint, String> _cardsData = {
    Endpoint.cases: 'Cases',
    Endpoint.casesSuspected: 'Suspected cases',
    Endpoint.casesConfirmed: 'Confirmed cases',
    Endpoint.deaths: 'Deaths',
    Endpoint.recovered: 'Recovered',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _cardsData[endpoint],
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                count?.toString() ?? '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
