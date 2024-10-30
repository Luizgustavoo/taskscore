class Frequency {
  String? matriculaId;
  String? nomePessoa;
  dynamic dia01;
  dynamic dia02;
  dynamic dia03;
  dynamic dia04;
  dynamic dia05;
  dynamic dia06;
  dynamic dia07;
  dynamic dia08;
  dynamic dia09;
  dynamic dia10;
  dynamic dia11;
  dynamic dia12;
  dynamic dia13;
  dynamic dia14;
  dynamic dia15;
  dynamic dia16;
  dynamic dia17;
  dynamic dia18;
  dynamic dia19;
  dynamic dia20;
  dynamic dia21;
  dynamic dia22;
  dynamic dia23;
  dynamic dia24;
  dynamic dia25;
  dynamic dia26;
  dynamic dia27;
  dynamic dia28;
  dynamic dia29;
  dynamic dia30;
  dynamic dia31;

  Frequency(
      {this.matriculaId,
      this.nomePessoa,
      this.dia01,
      this.dia02,
      this.dia03,
      this.dia04,
      this.dia05,
      this.dia06,
      this.dia07,
      this.dia08,
      this.dia09,
      this.dia10,
      this.dia11,
      this.dia12,
      this.dia13,
      this.dia14,
      this.dia15,
      this.dia16,
      this.dia17,
      this.dia18,
      this.dia19,
      this.dia20,
      this.dia21,
      this.dia22,
      this.dia23,
      this.dia24,
      this.dia25,
      this.dia26,
      this.dia27,
      this.dia28,
      this.dia29,
      this.dia30,
      this.dia31});

  Frequency.fromJson(Map<String, dynamic> json) {
    matriculaId = json['matricula_id'];
    nomePessoa = json['nome_pessoa'];
    dia01 = json['dia_01'] ?? '';
    dia02 = json['dia_02'] ?? '';
    dia03 = json['dia_03'] ?? '';
    dia04 = json['dia_04'] ?? '';
    dia05 = json['dia_05'] ?? '';
    dia06 = json['dia_06'] ?? '';
    dia07 = json['dia_07'] ?? '';
    dia08 = json['dia_08'] ?? '';
    dia09 = json['dia_09'] ?? '';
    dia10 = json['dia_10'] ?? '';
    dia11 = json['dia_11'] ?? '';
    dia12 = json['dia_12'] ?? '';
    dia13 = json['dia_13'] ?? '';
    dia14 = json['dia_14'] ?? '';
    dia15 = json['dia_15'] ?? '';
    dia16 = json['dia_16'] ?? '';
    dia17 = json['dia_17'] ?? '';
    dia18 = json['dia_18'] ?? '';
    dia19 = json['dia_19'] ?? '';
    dia20 = json['dia_20'] ?? '';
    dia21 = json['dia_21'] ?? '';
    dia22 = json['dia_22'] ?? '';
    dia23 = json['dia_23'] ?? '';
    dia24 = json['dia_24'] ?? '';
    dia25 = json['dia_25'] ?? '';
    dia26 = json['dia_26'] ?? '';
    dia27 = json['dia_27'] ?? '';
    dia28 = json['dia_28'] ?? '';
    dia29 = json['dia_29'] ?? '';
    dia30 = json['dia_30'] ?? '';
    dia31 = json['dia_31'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['matricula_id'] = matriculaId;
    data['nome_pessoa'] = nomePessoa;
    data['dia_01'] = dia01;
    data['dia_02'] = dia02;
    data['dia_03'] = dia03;
    data['dia_04'] = dia04;
    data['dia_05'] = dia05;
    data['dia_06'] = dia06;
    data['dia_07'] = dia07;
    data['dia_08'] = dia08;
    data['dia_09'] = dia09;
    data['dia_10'] = dia10;
    data['dia_11'] = dia11;
    data['dia_12'] = dia12;
    data['dia_13'] = dia13;
    data['dia_14'] = dia14;
    data['dia_15'] = dia15;
    data['dia_16'] = dia16;
    data['dia_17'] = dia17;
    data['dia_18'] = dia18;
    data['dia_19'] = dia19;
    data['dia_20'] = dia20;
    data['dia_21'] = dia21;
    data['dia_22'] = dia22;
    data['dia_23'] = dia23;
    data['dia_24'] = dia24;
    data['dia_25'] = dia25;
    data['dia_26'] = dia26;
    data['dia_27'] = dia27;
    data['dia_28'] = dia28;
    data['dia_29'] = dia29;
    data['dia_30'] = dia30;
    data['dia_31'] = dia31;
    return data;
  }
}
