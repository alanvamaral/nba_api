import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api/model/player.dart';

class TeamPage extends StatelessWidget {
  TeamPage({super.key});

  final List<Player> players = [];

  Future getPlayers() async {
    var response = await http.get(
        Uri.https(
          'api.balldontlie.io',
          '/v1/players',
        ),
        headers: {
          'Authorization': 'cfd95b26-f9b7-49dd-a849-9b59ff4aa7e2',
        });

    var jsonData = jsonDecode(response.body);

    for (var eachPlayer in jsonData['data']) {
      // print(eachPlayer);
      final player = Player(
        id: eachPlayer['id'],
        position: eachPlayer['position'],
        firstname: eachPlayer['first_name'],
        lastname: eachPlayer['last_name'],
      );
      players.add(player);
    }
    print(players.length);
  }

  @override
  Widget build(BuildContext context) {
    getPlayers();
    return const Placeholder();
  }
}
