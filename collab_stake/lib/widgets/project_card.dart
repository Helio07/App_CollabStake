import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab_stake/bloc/projetoBloc/projeto_bloc.dart';

class ProjectCard extends StatelessWidget {
  final String projectName;
  final int counter;
  final int projectId;
  final bool isFavorite;

  const ProjectCard({
    Key? key,
    required this.projectName,
    required this.counter,
    required this.projectId,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      final parts = name.trim().split(' ');
      if (parts.length == 1) {
        return parts[0].substring(0, 1).toUpperCase();
      } else {
        return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
      }
    }

    // Gera uma cor baseada no nome do projeto
    Color getColor(String name) {
      final hash = name.hashCode;
      final colorIndex = hash % Colors.primaries.length;
      return Colors.primaries[colorIndex].shade300;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Row(
            children: [
              // Quadrado colorido com iniciais
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: getColor(projectName),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    getInitials(projectName),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        projectName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'stakeholders: $counter',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () {

                print('Favoritar projeto: $isFavorite');
                context.read<ProjetoBloc>().add(
                  FavoritouProjetosEvent(idProjeto: projectId, favorito: !isFavorite),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
