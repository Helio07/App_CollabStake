import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateStakeholderScreen extends StatefulWidget {
  const CreateStakeholderScreen({super.key});

  @override
  State<CreateStakeholderScreen> createState() => _CreateStakeholderScreenState();
}

class _CreateStakeholderScreenState extends State<CreateStakeholderScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  String _interesse = 'Alto';
  String _influencia = 'Alto';
  String _tipo = 'Apoiador';
  final TextEditingController _dicasController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _cargoController.dispose();
    _dicasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return BlocBuilder<AutenticacaoBloc, AutenticacaoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 38,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: primaryColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'STAKEHOLDER',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: primaryColor),
          ),
          body: Form(
            key: _formKey,
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Nome',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          controller: _nomeController,
                          decoration: const InputDecoration(
                            hintText: 'Digite o nome do stakeholder',
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Informe o nome' : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Cargo',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          controller: _cargoController,
                          decoration: const InputDecoration(
                            hintText: 'Digite o cargo',
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Informe o cargo' : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Interesse',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: _interesse,
                                    items: ['Alto', 'Médio', 'Baixo']
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _interesse = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Influência',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: _influencia,
                                    items: ['Alto', 'Médio', 'Baixo']
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _influencia = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tipo',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: _tipo,
                          items: ['Apoiador', 'Neutro', 'Resistente']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _tipo = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Dicas para gestão do stakeholder',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextFormField(
                          controller: _dicasController,
                          decoration: const InputDecoration(
                            hintText: 'Exemplo: Mantenha comunicação frequente, envolva nas decisões...',
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Salvar lógica aqui
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Stakeholder salvo!')),
                              );
                            }
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        );
      },
    );
  }
}
