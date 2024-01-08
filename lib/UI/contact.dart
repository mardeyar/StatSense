import 'package:flutter/material.dart';
import 'package:statsense/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bugs / Features',
        style: AppBarStyle.appBarText,
        ),
        backgroundColor: AppBarStyle.appBarBackground,
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Bug Reports',
              style: BodyTextStyle.bodyTextStyleBold
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: BodyTextStyle.bodyTextStyleReg,
                children: [
                  TextSpan(
                    text: 'Any bug reports can be sent via ',
                  ),
                  _linkText(
                    'email',
                    'mailto:techdevmd@gmail.com?subject=StatSense Bug Report',
                  ),
                  TextSpan(
                    text: ' along with a brief description of the bug you encountered '
                        'and if possible, how to produce the bug. Please be sure to '
                        'also include your device and OS version if you can (ie. '
                        'Android: 13 or iPhone 12: iOS 16.4 etc). To see an ongoing list '
                        'of known bugs, please visit the issues tab on the ',
                  ),
                  _linkText(
                    'StatSense GitHub repo',
                    'https://github.com/mardeyar/nhl_streamers/issues'
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Feature Requests',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: BodyTextStyle.bodyTextStyleReg,
                children: [
                  TextSpan(
                    text: 'To request features for StatSense, please send an ',
                  ),
                  _linkText(
                    'email',
                    'mailto:techdevmd@gmail.com?subject=StatSense Feature Request',
                  ),
                  TextSpan(
                    text: ' and specify which features you would like to see implemented.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _linkText(String text, String link) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.blue,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          _launchURL(link);
        },
    );
  }

  // TODO: replace deprecated 'launch' function with 'launchURL'
  Future<void> _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}