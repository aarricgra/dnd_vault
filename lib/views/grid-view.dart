import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_vault/entities/character-entity.dart';
import 'package:dnd_vault/entities/player-entity.dart';
import 'package:dnd_vault/views/character-view.dart';
import 'package:dnd_vault/views/player-view.dart';
import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class GridViewScreen extends StatefulWidget {
  final String userType;
  final String optionChoseen;

  const GridViewScreen({super.key, required this.userType,required this.optionChoseen});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  List<dynamic> entitys = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchentitys();
  }

  Future<void> fetchentitys() async {
    String collectionName="";
    print(widget.optionChoseen);
    switch(widget.optionChoseen){
      case "Jugadores":
        collectionName="players";
        break;
      case "Personajes":
        collectionName="npcs";
        break;
      default:
        break;
    }
    final snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    final loaded = snapshot.docs.map((doc) {
      switch (widget.optionChoseen){
        case "Jugadores":
          print("entrar players");
          return PlayerEntity.fromMap(doc.data(), doc.id);
        case "Personajes":
          print("entrar npcs");
          return CharacterEntity.fromMap(doc.data());
        default:
          return List;
      }
      
    }).toList();

    setState(() {
      entitys = loaded;
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
                itemCount: entitys.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final entity = entitys[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        TurnPageRoute(
                          overleafColor: const Color(0xFFFFF8DC), // opcional: color del reverso
                          transitionDuration: const Duration(milliseconds: 1000), // opcional: duración
                          builder: (context) => 
                          widget.optionChoseen=="Jugadores"?
                            PlayerView(
                              userType: widget.userType,
                              player: entity,
                            )
                          :
                            CharacterView(
                              userType: widget.userType, 
                              character: entity
                            )
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
                                entity.portrait,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.optionChoseen=="Jugadores"?
                                entity.shortName
                                :
                                entity.name,
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
