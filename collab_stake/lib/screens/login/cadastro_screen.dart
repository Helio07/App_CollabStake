import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaRepitirController = TextEditingController();
  bool esconderSenha = true;
  bool esconderSenha2 = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AutenticacaoBloc, AutenticacaoState>(
        listener: (context, state) {
          if (state.cadastroRealizado) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cadastro realizado com sucesso!'),
              ),
            );
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: SingleChildScrollView(
          child: BlocBuilder<AutenticacaoBloc, AutenticacaoState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cadastro',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 150),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Bem-vindo !',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _nameController,
                          decoration: _buildInputDecoration(hint: 'Nome', icon: FontAwesomeIcons.user),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          onChanged: (value) {
                            context.read<AutenticacaoBloc>().add(ClearErroCadastroEvent());
                          },
                          decoration: _buildInputDecoration(hint: 'Email', icon: FontAwesomeIcons.envelope),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _senhaController,
                          obscureText: esconderSenha,
                          onChanged: (_) {
                            context.read<AutenticacaoBloc>().add(ClearErroCadastroEvent());
                          },
                          decoration: _buildInputDecoration(
                            hint: 'Senha',
                            icon: FontAwesomeIcons.lock,
                            hasSuffix: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _senhaRepitirController,
                          obscureText: esconderSenha2,
                          decoration: _buildInputDecoration(
                            hint: 'Repitir senha',
                            icon: FontAwesomeIcons.lock,
                            hasSuffix: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (value != _senhaController.text) {
                              return 'As senhas não conferem';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Exibe erro de e-mail, se houver.
                            context.watch<AutenticacaoBloc>().state.emailExistente
                                ? const Text(
                                    'E-mail já cadastrado',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                  )
                                : const SizedBox(),
                            // Exibe erro de senha, se houver.
                            context.watch<AutenticacaoBloc>().state.senhaInvalida
                                ? const Text(
                                    'Senha inválida',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AutenticacaoBloc>().add(
                                  SolicitouCadastrarEvent(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    senha: _senhaController.text,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                            ),
                            child: Builder(builder: (context) {
                              final state = context.watch<AutenticacaoBloc>().state;
                              return state.buscando
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'CADASTRAR',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    );
                            }),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Já possui uma conta ? "),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'Entrar',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  InputDecoration _buildInputDecoration({required String hint, required IconData icon, bool hasSuffix = false}) {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: FaIcon(icon, color: Colors.grey, size: 20.0),
      ),
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      suffixIcon: hasSuffix
          ? InkWell(
              onTap: () => setState(() {
                if (hint == 'Senha') {
                  esconderSenha = !esconderSenha;
                } else {
                  esconderSenha2 = !esconderSenha2;
                }
              }),
              child: Icon(
                (hint == 'Senha' ? esconderSenha : esconderSenha2)
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                size: 20,
              ),
            )
          : null,
    );
  }
}
