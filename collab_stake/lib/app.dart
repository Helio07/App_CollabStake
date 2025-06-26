import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:collab_stake/bloc/projetoBloc/projeto_bloc.dart';
import 'package:collab_stake/repositories/autenticacao_repository.dart';
import 'package:collab_stake/repositories/projeto_repository.dart';
import 'package:collab_stake/screens/dashboard/dashboard_screen.dart';
import 'package:collab_stake/screens/home_screen.dart';
import 'package:collab_stake/screens/login/cadastro_screen.dart';
import 'package:collab_stake/screens/login/login_screen.dart';
import 'package:collab_stake/screens/login/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AutenticacaoRepository _autenticacaoRepository = AutenticacaoRepository();
  final ProjetoRepository _projetoRepository = ProjetoRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AutenticacaoBloc(autenticacaoRepository: _autenticacaoRepository),
        ),
        BlocProvider(
          create: (context) => ProjetoBloc(projetoRepository: _projetoRepository),
        ),
       
      ],
      child: const AppView()
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      theme: ThemeData(
          primaryColor: const Color(0xFF246EB9) ,fontFamily: 'Roboto'),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/cadastro': (context) => const CadastroScreen(),
        '/home': (context) => const HomeScreen(),
        '/deshboard': (context) => const DashboardScreen(),
      },
    );
  }
}

