import 'package:flutter/material.dart';
import 'package:nhl/UI/teamdetails.dart';
import '../managers/standings_manager.dart';
import '../model/standings.dart';

class TeamStandings extends StatefulWidget {
  const TeamStandings({Key? key}) : super(key: key);

  @override
  _TeamStandingsState createState() => _TeamStandingsState();
}

class _TeamStandingsState extends State<TeamStandings> {
  final StandingsManager teamView = StandingsManager();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await teamView.fetchTeams();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Statistics'),
      ),
      body: FutureBuilder(
          future: teamView.fetchTeams(),
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
              return buildTeamList(teamView.teamList);
            }
          }
      ),
    );
  }

  Widget buildTeamList(List<Team> allTeams) {
    // Sort the teams alphabetically instead of by points
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
                        team.getTrendingAnalysis(),
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