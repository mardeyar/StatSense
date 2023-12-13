import 'dart:convert';
import 'package:http/http.dart' as http;

class NHLApi {
  // Builds the method to fetch data on current & upcoming games
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

  // Builds the methods to fetch data on current league standings
  static Future<Map<String, dynamic>> fetchTeamStandings() async {
    final standingsResponse = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/standings/now'),
    );

    if (standingsResponse.statusCode == 200) {
      return json.decode(standingsResponse.body);
    } else {
      throw Exception('Failed to load NHL standings');
    }
  }
}