class Team {
  String teamName;
  String teamAbbrev;
  String conference;
  String division;
  int gamesPlayed;
  int goalDiff;
  int goalsAgainst;
  int goalsFor;
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
  String streakCode;
  int streakCount;
  List<String> gameDates = [];
  double streamerScore;
  int totalGames;
  int offDays;

  Team({
    this.teamName = '',
    this.teamAbbrev = '',
    this.conference = '',
    this.division = '',
    this.gamesPlayed = 0,
    this.goalDiff = 0,
    this.goalsAgainst = 0,
    this.goalsFor = 0,
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
    this.streakCode = '',
    this.streakCount = 0,
    this.streamerScore = 0.0,
    this.totalGames = 0,
    this.offDays = 0,
    this.gameDates = const [],
  });

  /**
   * Fetches the teams logo from local storage, avoids network requests on each
   * screen redraw<br>
   * [returns]: Image of team logo
   */
  String getLogoURL() {
    return 'assets/images/team_logos/${teamAbbrev}.png';
  }

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'teamAbbrev': teamAbbrev,
      'conference': conference,
      'division': division,
      'gamesPlayed': gamesPlayed,
      'goalDiff': goalDiff,
      'goalsAgainst': goalsAgainst,
      'goalsFor': goalsFor,
      'last10GoalDiff': last10GoalDiff,
      'last10GoalsFor': last10GoalsFor,
      'last10GoalsAgainst': last10GoalsAgainst,
      'last10Losses': last10Losses,
      'last10Wins': last10Wins,
      'last10OTL': last10OTL,
      'last10Points': last10Points,
      'totalLosses': totalLosses,
      'totalWins': totalWins,
      'totalOTL': totalOTL,
      'streakCode': streakCode,
      'streakCount': streakCount,
      'gameDates': gameDates,
      'streamerScore': streamerScore,
      'totalGames': totalGames,
      'offDays': offDays,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamName: json['teamName'],
      teamAbbrev: json['teamAbbrev'],
      conference: json['conference'],
      division: json['division'],
      gamesPlayed: json['gamesPlayed'],
      goalDiff: json['goalDiff'],
      goalsAgainst: json['goalsAgainst'],
      goalsFor: json['goalsFor'],
      last10GoalDiff: json['last10GoalDiff'],
      last10GoalsFor: json['last10GoalsFor'],
      last10GoalsAgainst: json['last10GoalsAgainst'],
      last10Losses: json['last10Losses'],
      last10Wins: json['last10Wins'],
      last10OTL: json['last10OTL'],
      last10Points: json['last10Points'],
      totalLosses: json['totalLosses'],
      totalWins: json['totalWins'],
      totalOTL: json['totalOTL'],
      streakCode: json['streakCode'],
      streakCount: json['streakCount'],
      gameDates: List<String>.from(json['gameDates']),
      streamerScore: json['streamerScore'],
      totalGames: json['totalGames'],
      offDays: json['offDays'],
    );
  }

  /**
   * Uses a formula of teams last 10 games attributes to give an idea on trending
   * performance. Used to calculate teams 'streamerScore'<br>
   * [returns]: The final results of the formula
   */
  double getTrendScore() {
    double wins = last10Wins.toDouble() * 0.05;
    double points = last10Points.toDouble() * 0.05;
    double gf = (last10GoalsFor.toDouble() / 10) * 0.05;
    double ga = (last10GoalsAgainst.toDouble() / 10) * 0.05;

    double trendScore = (wins + points + gf) - ga;
    return trendScore;
  }
}