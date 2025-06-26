part of 'autenticacao_bloc.dart';

enum AutenticacaoStatus { authenticated, unauthenticated, unknown }

enum SenhaStatus { ok, incorreta }

class AutenticacaoState extends Equatable {
  const AutenticacaoState._({
    this.status = AutenticacaoStatus.unknown,
    this.credenciaisIncorretas = false,
    this.emailExistente = false,
    this.usuario,
    this.buscando = false,
    this.senhaInvalida = false,
    this.cadastroRealizado = false,
  });

  const AutenticacaoState.authenticated(Usuario usuario)
      : this._(status: AutenticacaoStatus.authenticated, usuario: usuario);

  const AutenticacaoState.unauthenticated()
      : this._(status: AutenticacaoStatus.unauthenticated);

  final AutenticacaoStatus status;
  final Usuario? usuario;
  final bool credenciaisIncorretas;
  final bool buscando;
  final bool emailExistente;
  final bool senhaInvalida;
  final bool cadastroRealizado;

  @override
  List<Object?> get props =>
      [status, usuario, credenciaisIncorretas, buscando, emailExistente, senhaInvalida, cadastroRealizado];

  AutenticacaoState copyWith({
    Usuario? usuario,
    bool? credenciaisIncorretas,
    bool? buscando,
    bool? emailExistente,
    bool? senhaInvalida,
    bool? cadastroRealizado,
  }) {
    return AutenticacaoState._(
      status: status,
      usuario: usuario ?? this.usuario,
      credenciaisIncorretas:
          credenciaisIncorretas ?? this.credenciaisIncorretas,
      buscando: buscando ?? false,
      emailExistente: emailExistente ?? this.emailExistente,
      senhaInvalida: senhaInvalida ?? this.senhaInvalida,
      cadastroRealizado: cadastroRealizado ?? false,
    );
  }
}
