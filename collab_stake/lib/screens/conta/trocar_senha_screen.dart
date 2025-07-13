import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrocarSenhaScreen extends StatefulWidget {
  const TrocarSenhaScreen({super.key});

  @override
  State<TrocarSenhaScreen> createState() => _TrocarSenhaScreenState();
}

class _TrocarSenhaScreenState extends State<TrocarSenhaScreen> {
  final TextEditingController senhaAtualController = TextEditingController();
  final TextEditingController senhaNovaController = TextEditingController();
  final TextEditingController repitidaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool esconderSenha1 = true;
  bool esconderSenha2 = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _atualizarDados() async {
    final String senhaAtual = senhaAtualController.text;
    final String senhaNova = senhaNovaController.text;
    final String repitida = repitidaController.text;

    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AutenticacaoBloc>().add(
          TrocouSenhaEvent(
            senhaAtual: senhaAtual,
            novaSenha: senhaNova,
            novaSenhaConfirmation: repitida,
          ),
        );
    
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return BlocListener<AutenticacaoBloc, AutenticacaoState>(
      listenWhen: (previous, current) =>
          previous.buscando != current.buscando ||
          previous.senhaInvalida != current.senhaInvalida,
      listener: (context, state) {
        if (state.senhaInvalida) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('A senha atual não confere'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (!state.buscando) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Senha atualizada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        }
      },
      child: BlocBuilder<AutenticacaoBloc, AutenticacaoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: primaryColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'TROCAR SENHA',
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
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: senhaAtualController,
                            obscureText: esconderSenha,
                            decoration: InputDecoration(
                                labelText: 'senha atual',
                                labelStyle: TextStyle(color: primaryColor),
                                floatingLabelStyle:
                                    TextStyle(color: primaryColor),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                      () => esconderSenha = !esconderSenha),
                                  child: Icon(
                                      esconderSenha
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      size: 20),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              if (value.length < 6) {
                                return 'A senha deve ter pelo menos 6 caracteres';
                              }
                              final hasUppercase =
                                  value.contains(RegExp(r'[A-Z]'));
                              final hasNumber = value.contains(RegExp(r'\d'));
                              if (!hasUppercase || !hasNumber) {
                                return 'A senha deve conter letra maiúscula e número';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: senhaNovaController,
                            obscureText: esconderSenha1,
                            decoration: InputDecoration(
                                labelText: 'senha nova',
                                labelStyle: TextStyle(color: primaryColor),
                                floatingLabelStyle:
                                    TextStyle(color: primaryColor),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                      () => esconderSenha1 = !esconderSenha1),
                                  child: Icon(
                                      esconderSenha1
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      size: 20),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              if (value.length < 6) {
                                return 'A senha deve ter pelo menos 6 caracteres';
                              }
                              final hasUppercase =
                                  value.contains(RegExp(r'[A-Z]'));
                              final hasNumber = value.contains(RegExp(r'\d'));
                              if (!hasUppercase || !hasNumber) {
                                return 'A senha deve conter letra maiúscula e número';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: repitidaController,
                            obscureText: esconderSenha2,
                            decoration: InputDecoration(
                                labelText: 'repita a senha',
                                labelStyle: TextStyle(color: primaryColor),
                                floatingLabelStyle:
                                    TextStyle(color: primaryColor),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                      () => esconderSenha2 = !esconderSenha2),
                                  child: Icon(
                                      esconderSenha2
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      size: 20),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }

                              if (value != senhaNovaController.text) {
                                return 'As senhas não coincidem';
                              }

                              return null;
                            },
                          ),
                          const Spacer(),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed:
                                  state.buscando ? null : _atualizarDados,
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
      ),
    );
  }
}
