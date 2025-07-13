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


class AtualizouDadosEvent extends AutenticacaoEvent {
  const AtualizouDadosEvent({this.name, this.email, this.telefone});
  final String? name;
  final String? email;
  final String? telefone;
}

class BuscoudadosEvent extends AutenticacaoEvent {}

class TrocouSenhaEvent extends AutenticacaoEvent {
  const TrocouSenhaEvent({required this.senhaAtual, required this.novaSenha, required this.novaSenhaConfirmation});
  final String senhaAtual;
  final String novaSenha;
  final String novaSenhaConfirmation;
}