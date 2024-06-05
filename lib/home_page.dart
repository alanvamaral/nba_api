import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api/model/team.dart';
import 'package:nba_api/team_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Team> teams = [];

  // get teams
  Future getTeams() async {
    var response = await http.get(
        Uri.https(
          'api.balldontlie.io',
          '/v1/teams',
        ),
        headers: {
          'Authorization': 'cfd95b26-f9b7-49dd-a849-9b59ff4aa7e2',
        });

    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        id: eachTeam['id'],
        abbreviation: eachTeam['abbreviation'],
        name: eachTeam['name'],
        city: eachTeam['city'],
        division: eachTeam['division'],
        fullName: eachTeam['full_name'],
        conference: eachTeam['conference'],
      );
      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamPage(),
              ),
            ),
            icon: const Icon(Icons.abc),
          )
        ],
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {
          //is it done loading? then show data
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeamPage(),
                          )),
                      leading: Text(teams[index].id.toString()),
                      title: Text(teams[index].abbreviation),
                      subtitle: Text(teams[index].city),
                    ),
                  ),
                );
              },
            );
          }

          // if it's still loading, show loading circular progress
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
