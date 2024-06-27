class CategoryAction {
  dynamic id;
  String? descricao;
  String? statusCategoria;

  CategoryAction({this.id, this.descricao, this.statusCategoria});

  CategoryAction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    statusCategoria = json['status_categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    data['status_categoria'] = statusCategoria;
    return data;
  }
}
