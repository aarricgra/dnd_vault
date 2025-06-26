import 'package:dnd_vault/views/grid-view.dart';
import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

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
                Navigator.push(
                  context,
                  TurnPageRoute(
                    overleafColor: const Color(0xFFFFF8DC), // opcional: color del reverso
                    transitionDuration: const Duration(milliseconds: 1000), // opcional: duración
                    builder: (context) => GridViewScreen(userType: userType,optionChoseen: section,),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red.shade800, width: 2),
                backgroundColor: const Color.fromARGB(255, 250, 237, 200), 
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
