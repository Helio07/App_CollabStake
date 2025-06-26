part of 'projeto_bloc.dart';


@immutable
abstract class ProjetoEvent {
  const ProjetoEvent();
}

class ListouProjetosEvent extends ProjetoEvent {
  const ListouProjetosEvent();
}

