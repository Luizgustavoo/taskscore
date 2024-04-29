class Student {
  String? idMatricula;
  String? nomePessoa;
  String? fotoPessoa;
  dynamic cash;

  Student({this.idMatricula, this.nomePessoa, this.fotoPessoa, this.cash});

  Student.fromJson(Map<String, dynamic> json) {
    idMatricula = json['id_matricula'];
    nomePessoa = json['nome_pessoa'];
    fotoPessoa = json['foto_pessoa'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_matricula'] = idMatricula;
    data['nome_pessoa'] = nomePessoa;
    data['foto_pessoa'] = fotoPessoa;
    data['cash'] = cash;
    return data;
  }
}
