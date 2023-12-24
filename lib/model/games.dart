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
  String date;
  int numberOfGames;
  bool offDay;
  List<Game> gameList = [];

  GameDate({
    this.date = '',
    this.numberOfGames = 0,
    this.offDay = true,
    required this.gameList,
  });
}