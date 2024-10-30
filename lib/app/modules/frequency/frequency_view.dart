import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/frequency_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';

class FrequencyView extends GetView<StudentController> {
  const FrequencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Frequência da Turma'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: _buildColumns(controller),
                  rows: _buildRows(controller),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Constrói as colunas da DataTable (primeira coluna será o nome dos alunos, as demais serão os dias)
  List<DataColumn> _buildColumns(StudentController controller) {
    List<DataColumn> columns = [
      const DataColumn(
        label: Text('Aluno', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ];

    for (int day = 1; day <= controller.numberOfDays; day++) {
      columns.add(DataColumn(
        label: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text('Dia $day',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ));
    }

    return columns;
  }

  // Constrói as linhas da DataTable (primeira célula será o nome, as demais serão P ou F)
  List<DataRow> _buildRows(StudentController controller) {
    return controller.listFrequency.map((student) {
      final String name = student.nomePessoa as String;
      final List<String> attendance = [
        student.dia01 ?? '',
        student.dia02 ?? '',
        student.dia03 ?? '',
        student.dia04 ?? '',
        student.dia05 ?? '',
        student.dia06 ?? '',
        student.dia07 ?? '',
        student.dia08 ?? '',
        student.dia09 ?? '',
        student.dia10 ?? '',
        student.dia11 ?? '',
        student.dia12 ?? '',
        student.dia13 ?? '',
        student.dia14 ?? '',
        student.dia15 ?? '',
        student.dia16 ?? '',
        student.dia17 ?? '',
        student.dia18 ?? '',
        student.dia19 ?? '',
        student.dia20 ?? '',
        student.dia21 ?? '',
        student.dia22 ?? '',
        student.dia23 ?? '',
        student.dia24 ?? '',
        student.dia25 ?? '',
        student.dia26 ?? '',
        student.dia27 ?? '',
        student.dia28 ?? '',
        student.dia29 ?? '',
        student.dia30 ?? '',
        student.dia31 ?? '',

        // Adicione mais dias conforme necessário
      ];

      List<DataCell> cells = [
        DataCell(Text(name)),
      ];

      for (var status in attendance) {
        cells.add(DataCell(Text(
          status.isEmpty ? '-' : status,
          style: TextStyle(
            color: status == 'P' ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        )));
      }

      return DataRow(cells: cells);
    }).toList();
  }
}
