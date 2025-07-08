import 'package:collab_stake/screens/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab_stake/bloc/autenticacaoBloc/autenticacao_bloc.dart';

class AjudaScreen extends StatefulWidget {
  const AjudaScreen({super.key});

  @override
  State<AjudaScreen> createState() => _AjudaScreenState();
}

class _AjudaScreenState extends State<AjudaScreen> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutenticacaoBloc, AutenticacaoState>(
      listener: (context, state) {
        if (state.status != AutenticacaoStatus.authenticated) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: BlocBuilder<AutenticacaoBloc, AutenticacaoState>(builder: (context, state) {       
        return Layout(
          selectedIndex: 1,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Center(
                  child: Text(
                    'Ajuda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}