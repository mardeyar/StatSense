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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 3.0),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF282828), Color(0xFF2A2A2A)],
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: BodyTextStyle.bodyTextStyleBold),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

}