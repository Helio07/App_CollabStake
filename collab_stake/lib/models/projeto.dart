import 'dart:convert';

class Projeto {
  int? id;
  String? nome;
  String? endereco;
  String? areaAtuacao;
  bool? favorito;
  String? descricao;
  String? dataInicio;
  String? dataFinal;
  String? createdAt;
  String? updatedAt;

  Projeto({
    this.id,
    this.nome,
    this.endereco,
    this.areaAtuacao,
    this.favorito,
    this.descricao,
    this.dataInicio,  
    this.dataFinal,
    this.createdAt,
    this.updatedAt,
  });

  factory Projeto.fromJson(Map<String, dynamic> json) {
    return Projeto(
      id: json['id'],
      nome: json['nome'],
      endereco: json['endereco'],
      areaAtuacao: json['area_atuacao'],
      favorito: json['favorito'],
      descricao: json['descricao'],
      dataInicio: json['data_inicio'],
      dataFinal: json['data_final'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'area_atuacao': areaAtuacao,
      'favorito': favorito,
      'descricao': descricao,
      'data_inicio': dataInicio,
      'data_final': dataFinal,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static List<Projeto> fromJsonList(List<dynamic> list) {
    return list.map((e) => Projeto.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Projeto{id: $id, nome: $nome, endereco: $endereco, areaAtuacao: $areaAtuacao, favorito: $favorito, descricao: $descricao, dataInicio: $dataInicio, dataFinal: $dataFinal, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
