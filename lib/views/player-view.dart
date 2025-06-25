import 'package:dnd_vault/entities/player-entity.dart';
import 'package:flutter/material.dart';

class PlayerView extends StatelessWidget {
  final String userType;
  final PlayerEntity player;

  const PlayerView({
    super.key,
    required this.userType,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8DC),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 👈 Alinea texto a la izquierda
          children: [
            Center(
              child: Text(
                player.fullName,
                style: TextStyle(
                  fontFamily: 'dndFont',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${player.race} - ${player.age} años',
                style: TextStyle(
                  fontFamily: 'dndFont',
                  fontSize: 18,
                  color: Colors.brown.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.network(
                player.image,
                width: 240,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Trasfondo',
              style: TextStyle(
                fontFamily: 'dndFont',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  player.background,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left, // 👈 Alineado a la izquierda
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
