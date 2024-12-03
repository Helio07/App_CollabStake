import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool esconderSenha = true;
  bool esconderSenha2 = true;
  bool manterConectado = true;
  bool _isPhone = false;
  String _previousText = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
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
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal:
                              12.0), // Ajusta o espaço superior e inferior
                      child: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                    hintText: 'Nome',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal:
                              12.0), // Ajusta o espaço superior e inferior
                      child: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _senhaController,
                  obscureText: esconderSenha,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal:
                              12.0), // Ajusta o espaço superior e inferior
                      child: FaIcon(
                        FontAwesomeIcons.lock,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                    hintText: 'Senha',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(() {
                        esconderSenha = !esconderSenha;
                      }),
                      child: Icon(
                          esconderSenha
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _senhaController,
                  obscureText: esconderSenha2,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal:
                              12.0), // Ajusta o espaço superior e inferior
                      child: FaIcon(
                        FontAwesomeIcons.lock,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                    hintText: 'Repitir senha',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(() {
                        esconderSenha2 = !esconderSenha2;
                      }),
                      child: Icon(
                          esconderSenha2 ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                          size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    child: const Text(
                      'CADASTRAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ja possui uma conta ? "),
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
      ),
    );
  }

  Widget buildFields() {
    return Form(
      key: _formKey,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Digite o email ou telefone"),
          //MySpacing.height(8),

          //MySpacing.height(20),
          Text("Digite a senha"),

          //MySpacing.height(8),
          // FlowKitTextField(
          //   controller: _senhaController,
          //   hintText: "Senha",
          //   obscureText: esconderSenha,
          //   suffixIcon: InkWell(
          //     onTap: () => setState(() {
          //       esconderSenha = !esconderSenha;
          //     }),
          //     child: Icon(esconderSenha ? LucideIcons.eyeOff : LucideIcons.eye,
          //         size: 20),
          //   ),
          // ),
        ],
      ),
    );
  }

  String _formatPhone(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');

    if (value.length > 11) {
      value = value.substring(0, 11);
    }

    String formatted = value;
    if (value.length >= 2) {
      formatted = '(${value.substring(0, 2)}) ';
      if (value.length >= 7) {
        formatted += '${value.substring(2, 7)}-${value.substring(7)}';
      } else if (value.length >= 6) {
        formatted += '${value.substring(2, 6)}-${value.substring(6)}';
      } else {
        formatted += value.substring(2);
      }
    }

    return formatted;
  }

  void _handleInputChange(String value) {
    final oldText = _emailController.text;
    final oldSelection = _emailController.selection;

    // Verifica se o valor contém letras, que indicam um possível e-mail
    bool containsLetters = RegExp(r'[a-zA-Z]').hasMatch(value);
    bool containsAtSymbol = value.contains('@');

    // Se contiver letras ou o "@" indica que pode ser um e-mail
    if (containsLetters || containsAtSymbol) {
      _isPhone = false;

      // Apenas atualiza o campo sem aplicar formatação de telefone
      _emailController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
    // Verifica se é um número e aplica a formatação de telefone
    else if (RegExp(r'^[0-9]+$')
        .hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
      _isPhone = true;

      if (value.length < _previousText.length) {
        _emailController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      } else {
        final formattedText = _formatPhone(value);
        _emailController.value = TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(
              offset: _calculateCursorPosition(
                  oldSelection.baseOffset, oldText, formattedText)),
        );
      }
    }
    // Se não for um número e não tiver letras ou "@", apenas atualiza o valor
    else {
      _isPhone = false;

      _emailController.value = TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }

    _previousText = _emailController.text;
  }

  int _calculateCursorPosition(
      int oldCursorPosition, String oldText, String newText) {
    if (oldText.isEmpty) return newText.length;

    final diff = newText.length - oldText.length;

    return oldCursorPosition + diff;
  }
}
