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

  Team({
    required this.teamName,
    required this.teamAbbrev,
    required this.conference,
    required this.division,
    required this.gamesPlayed,
    required this.goalDiff,
    required this.goalsAgainst,
    required this.goalsFor,
    required this.homeGoalDiff,
    required this.homeGoalsAgainst,
    required this.homeGoalsFor,
    required this.homeLosses,
    required this.homeWins,
    required this.homeOTL,
    required this.last10GoalDiff,
    required this.last10GoalsFor,
    required this.last10GoalsAgainst,
    required this.last10Losses,
    required this.last10Wins,
    required this.last10OTL,
    required this.last10Points,
    required this.totalLosses,
    required this.totalWins,
    required this.totalOTL,
    required this.roadGoalDiff,
    required this.roadGoalsAgainst,
    required this.roadGoalsFor,
    required this.roadLosses,
    required this.roadWins,
    required this.roadOTL,
    required this.streakCode,
    required this.streakCount,
  });

  // Generate a local URL to display team logos. This saves making a network request every time
  String getLogoURL() {
    return 'assets/images/team_logos/${teamAbbrev}.png';
  }

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
}