import 'package:collab_stake/screens/home_screen.dart';
import 'package:collab_stake/screens/login/cadastro_screen.dart';
import 'package:collab_stake/screens/login/login_screen.dart';
import 'package:collab_stake/screens/login/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override

   Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xFF246EB9),
        fontFamily: 'Roboto'
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/cadastro': (context) => const CadastroScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
