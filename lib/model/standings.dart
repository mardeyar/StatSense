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
  //String teamLogoURL;
  //List<String> roster;

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
    //required this.teamLogoURL,
    //required this.roster,
  });

  // Generate a local URL to display team logos. This saves making a network request every time
  String getLogoURL() {
    return 'assets/images/team_logos/${teamAbbrev}.png';
  }
}