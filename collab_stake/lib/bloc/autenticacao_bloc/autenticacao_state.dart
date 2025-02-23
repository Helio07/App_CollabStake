part of 'autenticacao_bloc.dart';

enum AutenticacaoStatus { authenticated, unauthenticated, unknown }
enum SenhaStatus { ok, incorreta }

class AutenticacaoState extends Equatable {
  const AutenticacaoState._({
    this.status = AutenticacaoStatus.unknown,
    this.credenciaisIncorretas = false,
    this.usuario,
    this.buscando = false,
  });

  const AutenticacaoState.authenticated(Usuario usuario)
      : this._(status: AutenticacaoStatus.authenticated, usuario: usuario);

  const AutenticacaoState.unauthenticated()
      : this._(status: AutenticacaoStatus.unauthenticated);

  final AutenticacaoStatus status;
  final Usuario? usuario;
  final bool credenciaisIncorretas;
  final bool buscando;

  @override
  List<Object?> get props => [status, usuario, credenciaisIncorretas, buscando];

  AutenticacaoState copyWith({
    Usuario? usuario,
    bool? credenciaisIncorretas,
    bool? buscando,
  }) {
    return AutenticacaoState._(
      status: status,
      usuario: usuario ?? this.usuario,
      credenciaisIncorretas: credenciaisIncorretas ?? this.credenciaisIncorretas,
      buscando: buscando ?? false,
    );
  }
}
