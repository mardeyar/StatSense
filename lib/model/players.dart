class Player {
  final int playerID;
  final String firstName;
  final String lastName;
  final num last5Goals;
  final num last5Assists;
  final num last5Pts;
  final num last5PlusMinus;
  final num last5PPG;
  final num last5Shots;
  final num last5PIM;
  double _performanceScore = 0;

  Player ({
    required this.playerID,
    required this.firstName,
    required this.lastName,
    required this.last5Goals,
    required this.last5Assists,
    required this.last5Pts,
    required this.last5PlusMinus,
    required this.last5PPG,
    required this.last5Shots,
    required this.last5PIM,
  });

  double get performanceScore => _performanceScore;

  set performanceScore(double value) {
    _performanceScore = value;
  }
}