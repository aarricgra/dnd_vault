import 'package:dnd_vault/views/players-grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userType;

  const HomeScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final List<String> sections = [
      'Jugadores',
      'Personajes',
      'Lugares',
      'Información',
      'Diario de Campaña',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC), // color pergamino
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8DC),
        elevation: 0,
        title: Text(
          'D&D Vault - $userType',
          style: TextStyle(
            fontFamily: 'dndFont',
            fontSize: 28,
            color: Colors.brown.shade900,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView.separated(
          itemCount: sections.length,
          separatorBuilder: (_, __) => const SizedBox(height: 30),
          itemBuilder: (context, index) {
            final section = sections[index];
            return OutlinedButton(
              onPressed: () {
                switch (section) {
                  case 'Jugadores':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayersGridScreen(userType: userType),
                      ),
                    );
                    break;
                  default:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrir: $section')),
                    );
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red.shade800, width: 2),
                backgroundColor: const Color.fromARGB(255, 250, 237, 200), // más oscuro que #FFF8DC
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                alignment: Alignment.centerLeft,
                foregroundColor: Colors.red.shade800,
              ),
              child: Text(
                section,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'dndFont',
                  fontSize: 24,
                  color: Colors.red.shade800,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
