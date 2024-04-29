class Ranking {
  String? idMatricula;
  String? nomePessoa;
  String? fotoPessoa;
  String? totalNotas;
  dynamic porcentagemPontos;

  Ranking(
      {this.idMatricula, this.nomePessoa, this.fotoPessoa, this.totalNotas});

  Ranking.fromJson(Map<String, dynamic> json) {
    idMatricula = json['id_matricula'];
    nomePessoa = json['nome_pessoa'];
    fotoPessoa = json['foto_pessoa'];
    totalNotas = json['total_notas'];
    porcentagemPontos = json['porcentagem_pontos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_matricula'] = idMatricula;
    data['nome_pessoa'] = nomePessoa;
    data['foto_pessoa'] = fotoPessoa;
    data['total_notas'] = totalNotas;
    data['porcentagem_pontos'] = porcentagemPontos;

    return data;
  }
}
