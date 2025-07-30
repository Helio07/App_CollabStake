import 'package:flutter/material.dart';

class StakeholderCard extends StatelessWidget {
  final String name;
  final String cargo;
  final String interesse;
  final String influencia;
  final String tipo; // 'Apoiador', 'Neutro', 'Resistente'
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const StakeholderCard({
    Key? key,
    required this.name,
    required this.cargo,
    required this.interesse,
    required this.influencia,
    required this.tipo,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  Color getTipoColor(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'apoiador':
        return Colors.green[100]!;
      case 'neutro':
        return Colors.yellow[100]!;
      case 'resistente':
        return Colors.red[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  Color getTipoTextColor(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'apoiador':
        return Colors.green[800]!;
      case 'neutro':
        return Colors.orange[800]!;
      case 'resistente':
        return Colors.red[800]!;
      default:
        return Colors.grey[800]!;
    }
  }

  Color getInteresseColor(String valor) {
    switch (valor.toLowerCase()) {
      case 'alto':
        return Colors.red;
      case 'médio':
        return Colors.orange;
      case 'baixo':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color getInfluenciaColor(String valor) {
    switch (valor.toLowerCase()) {
      case 'alto':
        return Colors.red;
      case 'médio':
        return Colors.orange;
      case 'baixo':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    } else {
      return (parts[0].substring(0, 1) + parts[1].substring(0, 1))
          .toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/deshboard/stakeholder/description');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue[400],
                    child: Text(
                      getInitials(name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 2,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        cargo,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Column(
                children: [
                  const Text(
                    'Interesse / Influência ',
                    style: TextStyle(fontSize: 13),
                  ),
                  Row(
                    children: [
                      Text(
                        interesse,
                        style: TextStyle(
                          color: getInteresseColor(interesse),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const Text(' / ', style: TextStyle(fontSize: 13)),
                      Text(
                        influencia,
                        style: TextStyle(
                          color: getInfluenciaColor(influencia),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: getTipoColor(tipo),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tipo,
                      style: TextStyle(
                        color: getTipoTextColor(tipo),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
