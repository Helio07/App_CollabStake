import 'package:collab_stake/bloc/projetoBloc/projeto_bloc.dart';
import 'package:collab_stake/screens/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';

class StakeholderScreen extends StatefulWidget {
  const StakeholderScreen({super.key});

  @override
  State<StakeholderScreen> createState() => _StakeholderScreenState();
}

class _StakeholderScreenState extends State<StakeholderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjetoBloc>().add(const ListouProjetosEvent());
  }

  @override
  Widget build(BuildContext context) {
    final projectId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocListener<AutenticacaoBloc, AutenticacaoState>(
      listener: (context, state) {
        if (state.status != AutenticacaoStatus.authenticated) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: BlocBuilder<ProjetoBloc, ProjetoState>(builder: (context, state) {
        final projeto = state.projetos.firstWhere(
          (p) => p.id == projectId,
          orElse: () => state.projetos.isNotEmpty ? state.projetos.first : throw Exception('No projetos found'),
        );
        return Layout(
          selectedIndex: 0,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Center(
                  child: Text(
                    projeto.nome ?? 'Projeto não encontrado',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}