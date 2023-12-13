class Team {
  final String teamName;
  final String conference;
  final String division;
  final int gamesPlayed;
  final int goalDiff;
  final int goalsAgainst;
  final int goalsFor;
  final int homeGoalDiff;
  final int homeGoalsAgainst;
  final int homeGoalsFor;
  final int homeLosses;
  final int homeWins;
  final int homeOTL;
  final int last10GoalDiff;
  final int last10GoalsFor;
  final int last10GoalsAgainst;
  final int last10Losses;
  final int last10Wins;
  final int last10OTL;
  final int totalLosses;
  final int totalWins;
  final int totalOTL;
  final int roadGoalDiff;
  final int roadGoalsAgainst;
  final int roadGoalsFor;
  final int roadLosses;
  final int roadWins;
  final int roadOTL;
  final String streakCode;
  final int streakCount;
  final String teamLogoURL;

  Team({
    required this.teamName,
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
    required this.teamLogoURL
  });
}