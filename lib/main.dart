import 'package:dnd_vault/screens/home-screen.dart';
import 'package:dnd_vault/update_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPKZ2BWXpfdjOFfRkzgOkNrNh7Rs5O0_4",
      authDomain: "dnd-vault.firebaseapp.com",
      projectId: "dnd-vault",
      storageBucket: "dnd-vault.appspot.com",
      messagingSenderId: "508424175231",
      appId: "1:508424175231:web:45514e2aef1a8d42fdc94a",
      measurementId: "G-YLDGKMV7TM",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EntryScreen(),
    );
  }
}

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool isMasterMode = false;
  final TextEditingController _passwordController = TextEditingController();
  String error = '';

  void goToHome(String userType) {
    Navigator.push(
      context,
      TurnPageRoute(
        overleafColor: const Color(0xFFFFF8DC),
        transitionDuration: const Duration(milliseconds: 1000),
        builder: (context) => HomeScreen(userType: userType),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AutoUpdateService().updateIfNecessary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Cover.png",
              fit: BoxFit.cover,
            ),
          ),
          if (isMasterMode)
            Positioned(
              top: 60,
              left: 40,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 42,
                color: const Color.fromARGB(255, 146, 101, 43),
                onPressed: () {
                  setState(() {
                    isMasterMode = false;
                    error = '';
                    _passwordController.clear();
                  });
                },
              ),
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: isMasterMode
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 370,),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8DC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Ingresa como Master',
                                style: TextStyle(
                                  fontFamily: 'dndFont',
                                  fontSize: 32,
                                  color: Colors.brown.shade900,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFF8DC),
                                  labelText: 'Contraseña',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  if (_passwordController.text == 'Asdf1234') {
                                    goToHome('master');
                                  } else {
                                    setState(() {
                                      error = 'Contraseña incorrecta';
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                  ),
                                ),
                                child: Text(
                                  'Acceder',
                                  style: TextStyle(
                                    fontFamily: 'dndFont',
                                    fontSize: 62,
                                    color: const Color.fromARGB(255, 146, 101, 43),
                                  ),
                                ),
                              ),
                              if (error.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    error,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 300),
                        TextButton(
                          onPressed: () => goToHome('player'),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.red.shade800),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 5.0),
                            ),
                          ),
                          child: Text(
                            'Jugador',
                            style: TextStyle(
                              fontFamily: 'dndFont',
                              fontSize: 62,
                              color: const Color.fromARGB(255, 146, 101, 43),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isMasterMode = true;
                            });
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.red.shade800),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 5.0),
                            ),
                          ),
                          child: Text(
                            'Master',
                            style: TextStyle(
                              fontFamily: 'dndFont',
                              fontSize: 62,
                              color: const Color.fromARGB(255, 146, 101, 43),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
