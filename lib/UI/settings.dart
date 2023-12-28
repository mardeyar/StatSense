import 'package:flutter/material.dart';
import 'package:nhl/utils/styles.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
          style: AppBarStyle.appBarText,
        ),
        backgroundColor: AppBarStyle.appBarBackground,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
          child: Text('Need to add some settings here',
          style: BodyTextStyle.bodyTextStyleReg
          ),
        ),
      ),
    );
  }
}