import 'package:coronavirus_tracker_board/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker_board/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker_board/app/services/api.dart';
import 'package:coronavirus_tracker_board/app/ui/endpoint_card.dart';
import 'package:coronavirus_tracker_board/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData.values[Endpoint.cases]?.date
            : null);
    return Scaffold(
      appBar: AppBar(title: Text('Coronavirus Tracker')),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdatesStatusText(
                text: formatter.lastUpdatedStatusText()),
            for (final endpoint in Endpoint.values)
              EndpointCard(
                  endpoint: endpoint,
                  count: _endpointsData != null
                      ? _endpointsData.values[endpoint]?.count
                      : null),
          ],
        ),
      ),
    );
  }
}
