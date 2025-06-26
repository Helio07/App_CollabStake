import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool esconderSenha = true;
  bool _isPhone = false;
  String _previousText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AutenticacaoBloc, AutenticacaoState>(
        listener: (context, state) {
          if (state.status == AutenticacaoStatus.authenticated) {
            Navigator.pushReplacementNamed(context, '/deshboard');
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
                          'Login',
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
                                'Bem-vindo de volta !',
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
                          controller: _emailController,
                          onChanged: _handleInputChange,
                          decoration: _buildInputDecoration(
                            hint: 'Email',
                            icon: FontAwesomeIcons.envelope,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (!_isPhone && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _senhaController,
                          obscureText: esconderSenha,
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
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            context.watch<AutenticacaoBloc>().state.credenciaisIncorretas
                                ? const Text(
                                    'Credenciais incorretas',
                                    style: TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.w500),
                                  )
                                : const SizedBox(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Esqueceu a senha ?',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AutenticacaoBloc>().add(
                                    SolicitouLoginEvent(
                                        email: _emailController.text,
                                        senha: _senhaController.text));
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
                                      'ENTRAR',
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
                            const Text("Não possui uma conta ? "),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/cadastro');
                              },
                              child: Text(
                                'Cadastre-se',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
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
              onTap: () => setState(() => esconderSenha = !esconderSenha),
              child: Icon(
                  esconderSenha ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                  size: 20),
            )
          : null,
    );
  }

  void _handleInputChange(String value) {
    // Dispara o evento para limpar erro de credenciais a cada mudança
    context.read<AutenticacaoBloc>().add(ClearErroCredenciaisEvent());

    final oldText = _emailController.text;
    final oldSelection = _emailController.selection;
    final containsLetters = RegExp(r'[a-zA-Z]').hasMatch(value);
    final containsAtSymbol = value.contains('@');

    if (containsLetters || containsAtSymbol) {
      _isPhone = false;
      _emailController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length));
    } else if (RegExp(r'^[0-9]+$').hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
      _isPhone = true;
      if (value.length < _previousText.length) {
        _emailController.value = TextEditingValue(
            text: value,
            selection: TextSelection.collapsed(offset: value.length));
      } else {
        final formattedText = _formatPhone(value);
        _emailController.value = TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(
              offset: _calculateCursorPosition(oldSelection.baseOffset, oldText, formattedText)),
        );
      }
    } else {
      _isPhone = false;
      _emailController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length));
    }
    _previousText = _emailController.text;
  }

  String _formatPhone(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length > 11) value = value.substring(0, 11);
    if (value.length < 2) return value;
    String formatted = '(${value.substring(0, 2)}) ';
    if (value.length >= 7) {
      formatted += '${value.substring(2, 7)}-${value.substring(7)}';
    } else if (value.length >= 6) {
      formatted += '${value.substring(2, 6)}-${value.substring(6)}';
    } else {
      formatted += value.substring(2);
    }
    return formatted;
  }

  int _calculateCursorPosition(int oldCursorPosition, String oldText, String newText) {
    final diff = newText.length - oldText.length;
    return oldCursorPosition + diff;
  }
}
