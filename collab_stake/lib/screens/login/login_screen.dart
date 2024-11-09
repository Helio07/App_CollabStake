import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool esconderSenha = true;
  bool manterConectado = true;
  bool _isPhone = false;
  String _previousText = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //_emailController.text = '(33) 99900-7564';
    //_senhaController.text = 'teste';
    _emailController.text = '(51) 99071-4295';
    _senhaController.text = '340729';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
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
              const SizedBox(height: 20),
              Text(
                'Bem-vindo de volta !',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
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
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Esqueceu a senha ?',
                    style: TextStyle(color: Theme.of(context).primaryColor),
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
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Não possui uma conta ? "),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cadastre-se',
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
