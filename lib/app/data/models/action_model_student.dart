class ActionModelStudent {
  int? id;
  String? acao;
  int? nota;

  ActionModelStudent({
    this.id,
    this.acao,
    this.nota,
  });

  ActionModelStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acao = json['acao'];
    nota = json['nota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['acao'] = acao;
    data['nota'] = nota;
    return data;
  }
}
