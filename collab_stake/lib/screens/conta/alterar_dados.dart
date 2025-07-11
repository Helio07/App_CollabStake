import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlterarDados extends StatefulWidget {
  const AlterarDados({super.key});

  @override
  State<AlterarDados> createState() => _AlterarDadosState();
}

class _AlterarDadosState extends State<AlterarDados> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nomeController.text =
        context.read<AutenticacaoBloc>().state.usuario?.data?.name ?? '';
    emailController.text =
        context.read<AutenticacaoBloc>().state.usuario?.data?.email ?? '';
    telefoneController.text =
        context.read<AutenticacaoBloc>().state.usuario?.data?.telefone ?? '';
  }

  Future<void> _atualizarDados() async {
    final String nome = nomeController.text;
    final String email = emailController.text;
    final String telefone = telefoneController.text;

    if (_formKey.currentState!.validate()) {
      context.read<AutenticacaoBloc>().add(
            AtualizouDadosEvent(
              name: nome,
              email: email,
              telefone: telefone,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return BlocBuilder<AutenticacaoBloc, AutenticacaoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: primaryColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'EDITAR INFORMAÇÕES PESSOAIS',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: nomeController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(color: primaryColor),
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'email',
                            labelStyle: TextStyle(color: primaryColor),
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: telefoneController,
                          decoration: InputDecoration(
                            labelText: 'telefone',
                            labelStyle: TextStyle(color: primaryColor),
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            final digitsOnly =
                                value.replaceAll(RegExp(r'\D'), '');

                            if (digitsOnly.length != 11) {
                              return 'O telefone deve conter 11 dígitos';
                            }

                            return null;
                          },
                        ),
                        const Spacer(),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: state.buscando ? null : _atualizarDados,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: onPrimary,
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state.buscando
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          onPrimary),
                                    ),
                                  )
                                : const Text('Atualizar'),
                          ),
                        ),
                        const SizedBox(height: 24),
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
