import 'package:flutter/material.dart';
import 'package:nhl/utils/styles.dart';
import '../UI/about.dart';
import '../UI/contact.dart';

class Settings extends StatelessWidget {
  final List<Widget> appPages = [
    About(),
    Contact(),
  ];
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
          child: ListView(
            children: <Widget>[
              _buildCard(
                context,
                'About',
                  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
              ),
              _buildCard(
                context,
                'Bug Reports/Feature Requests',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contact()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, VoidCallback onTap) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}