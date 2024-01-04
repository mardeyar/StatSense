import 'package:flutter/material.dart';
import 'package:nhl/utils/styles.dart';
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
                    text: 'Any bug reports can be emailed to ',
                  ),
                  _linkText(
                    'techdevmd@gmail.com',
                    'mailto:techdevmd@gmail.com?subject=StatSense Bug Report',
                  ),
                  TextSpan(
                    text: ' along with a brief description of the bug you encountered '
                        'and if possible, how to produce the bug. To see an ongoing list '
                        'of known bugs, please visit the issues tab on the StatSense '
                        'GitHub repo at '
                  ),
                  _linkText(
                    'https://github.com/mardeyar/nhl_streamers/issues',
                    'https://github.com/mardeyar/nhl_streamers/issues'
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

  Future<void> _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

}
