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
}