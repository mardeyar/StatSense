import 'dart:convert';
import 'package:http/http.dart' as http;

class NHLApi {
  static Future<Map<String, dynamic>> fetchScheduleData(String formattedDate) async {
    final response = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/schedule/$formattedDate'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load NHL Game data.');
    }
  }
}