class LoginModel {
  String? idUsuario;
  String? nomeUsuario;
  String? loginUsuario;
  String? email;
  String? statusUsuario;
  String? setorUsuario;
  String? perfilUsuario;
  String? sexoUsuario;
  String? avatar;
  String? idProfessor;

  LoginModel(
      {this.idUsuario,
      this.nomeUsuario,
      this.loginUsuario,
      this.email,
      this.statusUsuario,
      this.setorUsuario,
      this.perfilUsuario,
      this.sexoUsuario,
      this.avatar,
      this.idProfessor});

  LoginModel.fromJson(Map<String, dynamic> json) {
    idUsuario = json['id_usuario'];
    nomeUsuario = json['nome_usuario'];
    loginUsuario = json['login_usuario'];
    email = json['email'];
    statusUsuario = json['status_usuario'];
    setorUsuario = json['setor_usuario'];
    perfilUsuario = json['perfil_usuario'];
    sexoUsuario = json['sexo_usuario'];
    avatar = json['avatar'];
    idProfessor = json['id_professor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['nome_usuario'] = nomeUsuario;
    data['login_usuario'] = loginUsuario;
    data['email'] = email;
    data['status_usuario'] = statusUsuario;
    data['setor_usuario'] = setorUsuario;
    data['perfil_usuario'] = perfilUsuario;
    data['sexo_usuario'] = sexoUsuario;
    data['avatar'] = avatar;
    data['id_professor'] = idProfessor;
    return data;
  }
}
