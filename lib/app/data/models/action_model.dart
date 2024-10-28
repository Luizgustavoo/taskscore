class ActionModel {
  dynamic id;
  String? acao;
  String? nota;
  String? tipoAcao;
  String? statusAcao;
  String? categoriaacaoId;

  ActionModel(
      {this.id,
      this.acao,
      this.nota,
      this.tipoAcao,
      this.statusAcao,
      this.categoriaacaoId});

  ActionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acao = json['acao'];
    nota = json['nota'];
    tipoAcao = json['tipo_acao'];
    statusAcao = json['status_acao'];
    categoriaacaoId = json['categoriaacao_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['acao'] = acao;
    data['nota'] = nota;
    data['tipo_acao'] = tipoAcao;
    data['status_acao'] = statusAcao;
    data['categoriaacao_id'] = categoriaacaoId;
    return data;
  }
}
