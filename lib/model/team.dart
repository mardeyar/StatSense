import 'dart:convert';

import 'package:http/http.dart' as http;

class Team {
  String teamName;
  String teamAbbrev;
  String conference;
  String division;
  int gamesPlayed;
  int goalDiff;
  int goalsAgainst;
  int goalsFor;
  int homeGoalDiff;
  int homeGoalsAgainst;
  int homeGoalsFor;
  int homeLosses;
  int homeWins;
  int homeOTL;
  int last10GoalDiff;
  int last10GoalsFor;
  int last10GoalsAgainst;
  int last10Losses;
  int last10Wins;
  int last10OTL;
  int last10Points;
  int totalLosses;
  int totalWins;
  int totalOTL;
  int roadGoalDiff;
  int roadGoalsAgainst;
  int roadGoalsFor;
  int roadLosses;
  int roadWins;
  int roadOTL;
  String streakCode;
  int streakCount;
  List<int> roster = [];
  List<String> gameDates = [];
  double trendScore;
  double streamerScore;
  int totalGames;
  int offDays;


  /*
  * Don't want to be required to use each and every one of these parameters
  * just to create a new instance of a team object so initializing all of these
  * to either 'null' for string or '0' for int
  */
  Team({
    this.teamName = '',
    this.teamAbbrev = '',
    this.conference = '',
    this.division = '',
    this.gamesPlayed = 0,
    this.goalDiff = 0,
    this.goalsAgainst = 0,
    this.goalsFor = 0,
    this.homeGoalDiff = 0,
    this.homeGoalsAgainst = 0,
    this.homeGoalsFor = 0,
    this.homeLosses = 0,
    this.homeWins = 0,
    this.homeOTL = 0,
    this.last10GoalDiff = 0,
    this.last10GoalsFor = 0,
    this.last10GoalsAgainst = 0,
    this.last10Losses = 0,
    this.last10Wins = 0,
    this.last10OTL = 0,
    this.last10Points = 0,
    this.totalLosses = 0,
    this.totalWins = 0,
    this.totalOTL = 0,
    this.roadGoalDiff = 0,
    this.roadGoalsAgainst = 0,
    this.roadGoalsFor = 0,
    this.roadLosses = 0,
    this.roadWins = 0,
    this.roadOTL = 0,
    this.streakCode = '',
    this.streakCount = 0,
    this.trendScore = 0.0,
    this.streamerScore = 0.0,
    this.totalGames = 0,
    this.offDays = 0,
    this.gameDates = const [],
  });

  // Generate a local URL to display team logos. This saves making a network request every time
  String getLogoURL() {
    return 'assets/images/team_logos/${teamAbbrev}.png';
  }

  // Method to extract the playerID and add to the roster list
  Future<void> fetchRoster() async {
    final playerResponse = await http.get(
        Uri.parse('https://api-web.nhle.com/v1/roster/$teamAbbrev/current')
    );

    if (playerResponse.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(playerResponse.body);
      final List<dynamic> forwards = responseData['forwards'];
      final List<dynamic> defensemen = responseData['defensemen'];

      // Loop through to add all these playerID into the roster list
      for (var player in [...forwards, ...defensemen]) {
        roster.add(player['id']);
      }
    } else {
      throw Exception('Error: failed to load playerIDs for $teamName');
    }
  }

  // String method to show a quick summary of the teams recent performance
  String getTrendingAnalysis() {
    if (this.last10Points >= 0 && this.last10Points <= 7) {
      return "The ${teamName} have been a bit cold recently, mustering just "
          "${last10Points} points in their past 10 games and a ${last10Wins} - "
          "${last10Losses} - ${last10OTL} record.";
    } else if (this.last10Points >= 8 && this.last10Points <= 13) {
      return "The ${teamName} have been playing some good hockey, gaining ${last10Points} "
          "points in their past 10 games with a record of ${last10Wins} - ${last10Losses} - ${last10OTL}.";
    } else if (this.last10Points >= 14 && this.last10Points <= 20) {
      return "The ${teamName} have been running hot lately, getting points in "
          "(${last10Wins} + ${last10OTL}) of their last 10 games, good for ${last10Points} "
          "points. They have a ${last10Wins} - ${last10Losses} - ${last10OTL} "
          "record in their last 10.";
    } else {
      return "The program broke, this text should never have been shown";
    }
  }

  // Method to determine a trendScore; this will factor into streamerScores
  double getTrendScore() {
    // Pick some factors from last 10 games to determine streamerScore strength
    double goalDiffWeight = this.last10GoalDiff * 0.08;
    double ptsWeight = this.last10Points * 0.01;
    double winWeight = this.last10Wins * 0.02;
    double lossWeight = this.last10Losses * 0.02;

    double trendScore =  goalDiffWeight + ptsWeight + winWeight + lossWeight;
    return trendScore;
  }
}