import 'package:flutter/material.dart';

class ModalProjetoNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    final TextEditingController prazoController = TextEditingController();

    return AlertDialog(
      title: Text('Criar Novo Projeto'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do Projeto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: prazoController,
              decoration: InputDecoration(
                labelText: 'Prazo (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o modal
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Lógica para salvar o projeto
            final String nome = nomeController.text;
            final String descricao = descricaoController.text;
            final String prazo = prazoController.text;

            if (nome.isNotEmpty && descricao.isNotEmpty && prazo.isNotEmpty) {
              // Aqui você pode adicionar a lógica para salvar os dados
              print('Projeto Criado: $nome, $descricao, $prazo');
              Navigator.of(context).pop(); // Fecha o modal
            } else {
              // Exibe uma mensagem de erro se algum campo estiver vazio
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Por favor, preencha todos os campos')),
              );
            }
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}