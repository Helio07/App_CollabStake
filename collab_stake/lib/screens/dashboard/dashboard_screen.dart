import 'package:collab_stake/screens/dashboard/modal_projeto_new.dart';
import 'package:collab_stake/screens/layout/layout.dart';
import 'package:collab_stake/widgets/project_card.dart'; // novo import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab_stake/bloc/autenticacao_bloc/autenticacao_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AutenticacaoBloc, AutenticacaoState>(
      listener: (context, state) {
        // if (state.status != AutenticacaoStatus.authenticated) {
        //   Navigator.pushReplacementNamed(context, '/login');
        // }
      },
      child: Layout(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Center(
                child: Text(
                  'bem vindo fulano',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Projetos',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          
                        },
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ModalProjetoNew();
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProjectCard(
                    projectName: 'Projeto Alpha',
                    counter: 10,
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHbCyrLWWTmsc-Y7rtxA3q22sogeUWCDa3Tw&s',
                    isFavorite: false,
                    onFavoriteToggle: () {
                      print('Favoritar Projeto Alpha');
                    },
                  ),
                  ProjectCard(
                    projectName: 'Projeto Beta',
                    counter: 5,
                    imageUrl: 'https://via.placeholder.com/150',
                    isFavorite: true,
                    onFavoriteToggle: () {
                      print('Favoritar Projeto Beta');
                    },
                  ),
                  ProjectCard(
                    projectName: 'Projeto Gamma',
                    counter: 8,
                    imageUrl: 'https://via.placeholder.com/150',
                    isFavorite: false,
                    onFavoriteToggle: () {
                      print('Favoritar Projeto Gamma');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
