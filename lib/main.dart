import 'package:dnd_vault/screens/home-screen.dart';
import 'package:dnd_vault/update_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPKZ2BWXpfdjOFfRkzgOkNrNh7Rs5O0_4",
      authDomain: "dnd-vault.firebaseapp.com",
      projectId: "dnd-vault",
      storageBucket: "dnd-vault.firebasestorage.app", // 🔧 CORREGIDO: .app → .appspot.com
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
      MaterialPageRoute(builder: (context) => HomeScreen(userType: userType)),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AutoUpdateService().updateIfNecessary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC), // Color pergamino real
      appBar:
          isMasterMode
              ? AppBar(
                backgroundColor: const Color(0xFFFFF8DC),
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      isMasterMode = false;
                      error = '';
                      _passwordController.clear();
                    });
                  },
                ),
                elevation: 0,
              )
              : null,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child:
              isMasterMode
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
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
                          overlayColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20.0),
                          ),
                        ),
                        child: Text(
                          'Acceder',
                          style: TextStyle(
                            fontFamily: 'dndFont',
                            fontSize: 32,
                            color: Colors.red.shade800,
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
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Dice.png", height: 160,width: 160,),
                      SizedBox(height: 10,),
                      Text(
                        'Selecciona tu rol',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'dndFont',
                          fontSize: 44,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Botón JUGADOR
                      TextButton(
                        onPressed: () => goToHome('player'),
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.red.shade800,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20.0),
                          ),
                        ),
                        child: Text(
                          'Jugador',
                          style: TextStyle(
                            fontFamily: 'dndFont',
                            fontSize: 32,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Botón MASTER
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isMasterMode = true;
                          });
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.red.shade800,
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20.0),
                          ),
                        ),
                        child: Text(
                          'Master',
                          style: TextStyle(
                            fontFamily: 'dndFont',
                            fontSize: 32,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
