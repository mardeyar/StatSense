import 'package:flutter/material.dart';
import '../utils/styles.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About',
        style: AppBarStyle.appBarText,
        ),
        backgroundColor: AppBarStyle.appBarBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'StatSense',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 8.0),
            Text(
              'Version: 1.0.0\nAuthored by: Mark Deyarmond',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            SizedBox(height: 16.0),
            Text(
              'Description',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 8.0),
            Text(
              'StatSense is designed to assist you with your weekly pickups and '
                  'drops for Fantasy Sports to help maximize your total games '
                  'played for the week.',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            SizedBox(height: 16.0),
            Text(
              'Schedule',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 8.0),
            Text(
              'The schedule page shows the total number of games for any given '
                  'day this week along with which teams are playing on each specific '
                  'day.',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            SizedBox(height: 16.0),
            Text(
              'Streamer Scores', // Add your app description here
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 8.0),
            Text(
              'The Streamer Scores page uses a unique formula to determine which '
                  'teams are best to target players from for your weekly drops '
                  'and pickups. Each team is given a score based on this formula '
                  'and is listed from top teams to bottom. Tap on a teams streamer '
                  'card to view more details.',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
          ],
        ),
      ),
    );
  }
}
