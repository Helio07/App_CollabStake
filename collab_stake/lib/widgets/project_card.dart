import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String projectName;
  final int counter;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProjectCard({
    Key? key,
    required this.projectName,
    required this.counter,
    required this.imageUrl,
    this.isFavorite = false,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Row(
            children: [
              // Conteúdo à esquerda: nome e contador
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        projectName,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Contador: $counter',
                      ),
                    ],
                  ),
                ),
              ),
              // Imagem quadrada à direita
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          // Ícone de estrela para favoritar no canto superior direito
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: onFavoriteToggle,
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
