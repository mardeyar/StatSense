import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Text('Settings'),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
          child: Text('Need to add some settings here'),
        ),
      ),
    );
  }
}