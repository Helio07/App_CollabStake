part of 'autenticacao_bloc.dart';

@immutable
abstract class AutenticacaoEvent {
  const AutenticacaoEvent();
}

class SolicitouLoginEvent extends AutenticacaoEvent {
  const SolicitouLoginEvent({required this.email, required this.senha});
  final String email;
  final String senha;
}

class SolicitouCadastrarEvent extends AutenticacaoEvent {
  const SolicitouCadastrarEvent({required this.name, required this.email, required this.senha});
  final String name;
  final String email;
  final String senha;
}

class ClearErroCredenciaisEvent extends AutenticacaoEvent {}

class ClearErroCadastroEvent extends AutenticacaoEvent {}