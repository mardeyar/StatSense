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
  //double trendScore;
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

  // Generate a local URL to display team logos. This saves making a network request every time
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
      //'trendScore': trendScore,
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
      //trendScore: json['trendScore'],
      streamerScore: json['streamerScore'],
      totalGames: json['totalGames'],
      offDays: json['offDays'],
    );
  }

  double getTrendScore() {
    double wins = last10Wins.toDouble() * 0.05;
    //double losses = last10Losses.toDouble() * 0.01;
    double points = last10Points.toDouble() * 0.02;
    double gf = (last10GoalsFor.toDouble() / 10) * 0.3;
    double ga = (last10GoalsAgainst.toDouble() / 10) * 0.05;

    double trendScore = (wins + points + gf) - ga;
    return trendScore;
  }
}