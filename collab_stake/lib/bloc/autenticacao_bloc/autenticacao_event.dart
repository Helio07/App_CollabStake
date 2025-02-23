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

// Novo evento para limpar erro de credenciais.
class ClearErroCredenciaisEvent extends AutenticacaoEvent {}