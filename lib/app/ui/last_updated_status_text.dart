import 'package:flutter/material.dart';

class LastUpdatesStatusText extends StatelessWidget {
  const LastUpdatesStatusText({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text
        ),
      ),
    );
  }
}