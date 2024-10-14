import 'package:taskscore/app/data/models/action_model_student.dart';
import 'package:taskscore/app/data/models/observation_model.dart';

class Student {
  dynamic idMatricula;
  String? nomePessoa;
  String? fotoPessoa;
  dynamic cash;
  List<ActionModelStudent>? actions;
  List<Observation>? observations;

  Student(
      {this.idMatricula,
      this.nomePessoa,
      this.fotoPessoa,
      this.cash,
      this.actions});

  Student.fromJson(Map<String, dynamic> json) {
    idMatricula = json['id_matricula'];
    nomePessoa = json['nome_pessoa'];
    fotoPessoa = json['foto_pessoa'];
    cash = json['cash'];
    if (json['acoes'] != null) {
      actions = <ActionModelStudent>[];
      json['acoes'].forEach((v) {
        actions!.add(ActionModelStudent.fromJson(v));
      });
    }
    if (json['observacoes'] != null) {
      observations = <Observation>[];
      json['observacoes'].forEach((v) {
        observations!.add(Observation.fromJson(v));
      });
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id_matricula'] = idMatricula;
      data['nome_pessoa'] = nomePessoa;
      data['foto_pessoa'] = fotoPessoa;
      data['cash'] = cash;
      if (actions != null) {
        data['acoes'] = actions!.map((v) => v.toJson()).toList();
      }
      if (observations != null) {
        data['observacoes'] = observations!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }
}
