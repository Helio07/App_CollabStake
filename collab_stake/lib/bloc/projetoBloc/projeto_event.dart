part of 'projeto_bloc.dart';


@immutable
abstract class ProjetoEvent {
  const ProjetoEvent();
}

class ListouProjetosEvent extends ProjetoEvent {
  const ListouProjetosEvent();
}

class CriouProjetosEvent extends ProjetoEvent {
  const CriouProjetosEvent({
    required this.nome,
    required this.endereco,
    required this.areaAtuacao,
    required this.descricao,
    required this.dataInicio,
    required this.dataFinal,
  });
  final String nome;
  final String endereco;
  final String areaAtuacao;
  final String descricao;
  final String dataInicio;
  final String dataFinal;
}

class FavoritouProjetosEvent extends ProjetoEvent {
  const FavoritouProjetosEvent({
    required this.favorito
  });
  final bool favorito;
}