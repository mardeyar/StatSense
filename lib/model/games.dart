class Game {
  final String date;
  final String awayTeam;
  final String homeTeam;

  Game({
    required this.date,
    required this.awayTeam,
    required this.homeTeam,
  });
}

class GameDate {
  final String date;
  final int numberOfGames;
  final bool offDay;
  final List<Game> gameList;

  GameDate({
    required this.date,
    required this.numberOfGames,
    required this.offDay,
    required this.gameList,
  });
}

class Team {
  final String teamName;
  int totalGames;
  int offDays;
  double streamerScore;
  List<String> gameDates;

  Team({
    required this.teamName,
    this.totalGames = 0,
    this.offDays = 0,
    this.streamerScore = 0,
    this.gameDates = const[],
  });
}