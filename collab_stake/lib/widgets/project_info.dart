import 'package:flutter/material.dart';

class ProjetoInfo extends StatelessWidget {
  final String titulo;
  final String subTitulo;
  final IconData icone;
  final Color iconColor;
  final Color backgroundColor;

  const ProjetoInfo({
    super.key,
    required this.titulo,
    required this.subTitulo,
    required this.icone,
    this.iconColor = const Color(0xFF246EB9),
    this.backgroundColor = const Color(0xFFEBF2FA),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icone,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitulo,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis, // adiciona "..." no final
                softWrap: false, // impede quebra de linha
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
