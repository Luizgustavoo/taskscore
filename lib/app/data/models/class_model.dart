class Class {
  String? idDia;
  String? numeroAula;
  String? idProfessor;
  String? idOficina;
  String? idHorario;
  String? alias;

  Class(
      {this.idDia,
      this.numeroAula,
      this.idProfessor,
      this.idOficina,
      this.idHorario,
      this.alias});

  Class.fromJson(Map<String, dynamic> json) {
    idDia = json['idDia'];
    numeroAula = json['numeroAula'];
    idProfessor = json['idProfessor'];
    idOficina = json['idOficina'];
    idHorario = json['idHorario'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDia'] = idDia;
    data['numeroAula'] = numeroAula;
    data['idProfessor'] = idProfessor;
    data['idOficina'] = idOficina;
    data['idHorario'] = idHorario;
    data['alias'] = alias;
    return data;
  }
}
