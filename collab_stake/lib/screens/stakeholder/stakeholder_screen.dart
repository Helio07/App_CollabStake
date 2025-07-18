import 'package:collab_stake/bloc/projetoBloc/projeto_bloc.dart';
import 'package:collab_stake/screens/layout/layout.dart';
import 'package:collab_stake/widgets/project_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:intl/intl.dart';

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
          orElse: () => state.projetos.isNotEmpty
              ? state.projetos.first
              : throw Exception('No projetos found'),
        );
        return Layout(
          selectedIndex: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        projeto.nome ?? 'Projeto não encontrado',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Ação ao clicar no botão de editar
                        print('Editar projeto');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Ação ao clicar no botão de excluir
                        print('Excluir projeto');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    childAspectRatio: 3.2,
                    shrinkWrap: true,
                    children: [
                      ProjetoInfo(
                        titulo: projeto.areaAtuacao ?? 'Área não informada',
                        subTitulo: 'Área de Atuação',
                        icone: Icons.work,
                      ),
                      ProjetoInfo(
                        titulo: projeto.endereco ?? 'Endereço não informada',
                        subTitulo: 'Endereço',
                        icone: Icons.location_on,
                        iconColor: Colors.amber[800]!,
                        backgroundColor: Colors.amber[100]!,
                      ),
                      ProjetoInfo(
                        titulo: formatarData(projeto.dataInicio),
                        subTitulo: 'Data de Início',
                        icone: Icons.flag,
                        iconColor: Colors.green[800]!,
                        backgroundColor: Colors.green[100]!,
                      ),
                      ProjetoInfo(
                        titulo: formatarData(projeto.dataFinal),
                        subTitulo: 'Data de Término',
                        icone: Icons.dangerous_outlined,
                        iconColor: Colors.red[700]!,
                        backgroundColor: Colors.red[100]!,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(top: 8),
                  child: SingleChildScrollView(
                    child: Text(
                      projeto.descricao ?? 'Descrição não informada',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String formatarData(dynamic data) {
    if (data == null) return 'Data não informada';
    try {
      final date = data is DateTime ? data : DateTime.tryParse(data.toString());
      if (date == null) return 'Data inválida';
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return 'Data inválida';
    }
  }
}
