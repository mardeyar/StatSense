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

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'numberOfGames': numberOfGames,
      'offDay': offDay,
      'gameList': gameList.map((game) => game.toJson()).toList(),
    };
  }

  factory GameDate.fromJson(Map<String, dynamic> json) {
    return GameDate(
      date: json['date'],
      numberOfGames: json['numberOfGames'],
      offDay: json['offDay'],
      gameList: (json['gameList'] as List<dynamic>)
          .map((gameJson) => Game.fromJson(gameJson))
          .toList(),
    );
  }
}

class Game {
  final String date;
  final String awayTeam;
  final String homeTeam;

  Game({
    required this.date,
    required this.awayTeam,
    required this.homeTeam,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'awayTeam': awayTeam,
      'homeTeam': homeTeam,
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      date: json['date'],
      awayTeam: json['awayTeam'],
      homeTeam: json['homeTeam'],
    );
  }
}
