class Player {
  final double playerID;
  final String firstName;
  final String lastName;
  final double last5Goals;
  final double last5Assists;
  final double last5Pts;
  final double last5PlusMinus;
  final double last5PPG;
  final double last5Shots;
  final double last5PIM;

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
}