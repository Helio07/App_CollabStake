import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:collab_stake/bloc/projetoBloc/projeto_bloc.dart';
import 'package:collab_stake/repositories/autenticacao_repository.dart';
import 'package:collab_stake/repositories/projeto_repository.dart';
import 'package:collab_stake/screens/ajuda/ajuda_screen.dart';
import 'package:collab_stake/screens/conta/conta_screen.dart';
import 'package:collab_stake/screens/dashboard/dashboard_screen.dart';
import 'package:collab_stake/screens/login/cadastro_screen.dart';
import 'package:collab_stake/screens/login/login_screen.dart';
import 'package:collab_stake/screens/login/welcome_screen.dart';
import 'package:collab_stake/screens/stakeholder/description_stakeholder_scree.dart';
import 'package:collab_stake/screens/stakeholder/stakeholder_screen.dart';
import 'package:collab_stake/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AutenticacaoRepository _autenticacaoRepository =
      AutenticacaoRepository();
  final ProjetoRepository _projetoRepository = ProjetoRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            AutenticacaoBloc(autenticacaoRepository: _autenticacaoRepository),
      ),
      BlocProvider(
        create: (context) => ProjetoBloc(projetoRepository: _projetoRepository),
      ),
    ], child: const AppView());
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late Future<bool> _usuarioLogado;

  @override
  void initState() {
    super.initState();
    _usuarioLogado = _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _usuarioLogado,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AutenticacaoBloc, AutenticacaoState>(
              builder: (context, state) {
                if (state.status == AutenticacaoStatus.authenticated) {
                  return const DashboardScreen();
                } else {
                  return const WelcomeScreen();
                }
              },
            ),
            theme: ThemeData(
              primaryColor: const Color(0xFF246EB9),
              fontFamily: 'Roboto',
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF246EB9),
                secondary: Color(0xFFEBF2FA),
                onPrimary: Colors.white,
                onSecondary: Color(0xFFC9CAD9),
                onSurface: Color(0xFF333333),
              ),
            ),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/cadastro': (context) => const CadastroScreen(),
              '/deshboard': (context) => const DashboardScreen(),
              '/deshboard/stakeholder': (context) => const StakeholderScreen(),
              '/deshboard/stakeholder/description': (context) => const DescriptionScree(),
              '/deshboard/conta': (context) => const ContaScreen(),
              '/deshboard/ajuda': (context) => const AjudaScreen(),
            },
          );
        });
  }

  Future<bool> _verificarUsuarioLogado() async {
    final prefs = LocalStorageService();
    var usuario = await prefs.getString('usuario');
    var usuarioSalvo = usuario != null;
    if (usuarioSalvo) {
      context.read<AutenticacaoBloc>().add(CarregouUsuarioLogadoEvent());
    } else {
      context
          .read<AutenticacaoBloc>()
          .add(const SetouUsuarioNaoAutenticadoEvent());
    }
    return usuarioSalvo;
  }
}
