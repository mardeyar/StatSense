import 'package:flutter/material.dart';
import 'package:nhl/UI/teamdetails.dart';
import '../managers/function_manager.dart';
import '../model/team.dart';

class TeamStandings extends StatefulWidget {
  const TeamStandings({Key? key}) : super(key: key);

  @override
  _TeamStandingsState createState() => _TeamStandingsState();
}

class _TeamStandingsState extends State<TeamStandings> {
  final appFunction = FunctionManager();
  late Future<void> teamsFuture;

  @override
  void initState() {
    super.initState();
    teamsFuture = appFunction.fetchGameData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Statistics'),
      ),
      body: FutureBuilder(
        future: appFunction.fetchGameData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              // If the data is loading, display a loading circle
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error fetching NHL Teams data..."),
            );
          } else {
            // Use the data when available
            final teamMap = appFunction.teamMap.values.toList();
            return buildTeamList(teamMap);
          }
        },
      ),
    );
  }


  Widget buildTeamList(List<Team> allTeams) {
    // Sort the teams alphabetically instead of by points
    print('Team list $allTeams');
    allTeams.sort((a, b) => a.teamName.compareTo(b.teamName));

    return ListView.builder(
      itemCount: allTeams.length,
      itemBuilder: (context, index) {
        final team = allTeams[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamDetails(team: team),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.asset(
                    team.getLogoURL(),
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 8),
                  Text(
                    team.teamName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        appFunction.getTrendingAnalysis(team),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}