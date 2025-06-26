import 'package:dnd_vault/entities/character-entity.dart';
import 'package:flutter/material.dart';

class CharacterView extends StatelessWidget {
  final String userType;
  final CharacterEntity character;

  const CharacterView({
    super.key,
    required this.userType,
    required this.character,
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
                character.name,
                style: TextStyle(
                  fontFamily: 'dndFont',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            if (character.title.isNotEmpty)...[
              const SizedBox(height: 8),
              Center(
                child: Text(
                  character.title,
                  style: TextStyle(
                    fontFamily: 'dndFont',
                    fontSize: 18,
                    color: Colors.brown.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 20),
            Center(
              child: Image.network(
                character.image,
                width: 240,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Historia',
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
                  character.lore,
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
