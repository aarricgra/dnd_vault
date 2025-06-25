import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_vault/entities/player-entity.dart';
import 'package:dnd_vault/views/player-view.dart';
import 'package:flutter/material.dart';

class PlayersGridScreen extends StatefulWidget {
  final String userType;

  const PlayersGridScreen({super.key, required this.userType});

  @override
  State<PlayersGridScreen> createState() => _PlayersGridScreenState();
}

class _PlayersGridScreenState extends State<PlayersGridScreen> {
  List<PlayerEntity> players = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  Future<void> fetchPlayers() async {
    final snapshot = await FirebaseFirestore.instance.collection('players').get();
    final loaded = snapshot.docs.map((doc) {
      return PlayerEntity.fromMap(doc.data(), doc.id);
    }).toList();

    setState(() {
      players = loaded;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8DC),
        elevation: 0,
        title: Text(
          'Jugadores',
          style: TextStyle(
            fontFamily: 'dndFont',
            fontSize: 24,
            color: Colors.brown.shade900,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: players.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final player = players[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlayerView(
                            userType: widget.userType,
                            player: player,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 250, 237, 200),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.red.shade800, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                              child: Image.network(
                                player.portrait,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              player.shortName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'dndFont',
                                fontSize: 18,
                                color: Colors.brown.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
