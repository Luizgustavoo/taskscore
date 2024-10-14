class Observation {
  String? id;
  String? observacao;
  String? matriculaId;
  String? usuarioId;
  String? createdAt;
  String? updatedAt;

  Observation(
      {this.id,
      this.observacao,
      this.matriculaId,
      this.usuarioId,
      this.createdAt,
      this.updatedAt});

  Observation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    observacao = json['observacao'];
    matriculaId = json['matricula_id'];
    usuarioId = json['usuario_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['observacao'] = observacao;
    data['matricula_id'] = matriculaId;
    data['usuario_id'] = usuarioId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
