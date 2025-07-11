import 'dart:convert';

class Usuario {
  final String? token;
  DadosUsuario? data;

  Usuario({
    required this.token,
    required this.data,
  });

  Usuario copyWith({
    String? token,
    DadosUsuario? data,
  }) {
    return Usuario(
      token: token ?? this.token,
      data: data ?? this.data,
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      token: json['token'],
      data: json['data'] != null ? DadosUsuario.fromJson(json['data']) : null,
    );
  }

  String toJson() {
    final Map<String, dynamic> mapData = {
      'token': token,
      'data': data?.toJson(),
    };
    return jsonEncode(mapData);
  }
}

class DadosUsuario {
  int? id;
  String? email;
  String? name;
  String? telefone;


  DadosUsuario({
    this.id,
    this.email,
    this.name,
    this.telefone,
  });

  factory DadosUsuario.fromJson(Map<String, dynamic> json) {
    return DadosUsuario(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      telefone: json['telefone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'telefone': telefone,
    };
  }
}
