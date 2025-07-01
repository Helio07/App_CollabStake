part of 'projeto_bloc.dart';

class ProjetoState extends Equatable {
  const ProjetoState({
    this.projetos = const [],
  });

  final List<Projeto> projetos;

  @override
  List<Object?> get props => [projetos];

  ProjetoState copyWith({
    List<Projeto>? projetos,
  }) {
    return ProjetoState(
      projetos: projetos ?? this.projetos,
    );
  }
}

