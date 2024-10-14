import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/student_model.dart';

class StudentDetailsView extends StatelessWidget {
  final Student student;
  final StudentController controller;

  const StudentDetailsView(
      {super.key, required this.student, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.nomePessoa!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hero image, centralizada na coluna
            Hero(
              tag: 'studentHeroTag_${student.idMatricula}',
              child: CircleAvatar(
                radius: 100,
                backgroundImage:
                    student.fotoPessoa == null || student.fotoPessoa!.isEmpty
                        ? const AssetImage('assets/images/default_avatar.jpg')
                        : NetworkImage('$foto/${student.fotoPessoa}')
                            as ImageProvider,
              ),
            ),
            const SizedBox(height: 20), // Espaço entre a imagem e o card

            // Card com as observações do aluno
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Observações do aluno:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    // Verificar se há observações
                    student.observations != null &&
                            student.observations!.isNotEmpty
                        ? SizedBox(
                            height: 260, // Limite de altura para o ListView
                            child: ListView.builder(
                              itemCount: student.observations!.length,
                              itemBuilder: (context, index) {
                                final observation =
                                    student.observations![index];
                                final id = observation.id!;
                                return ListTile(
                                  trailing: IconButton(
                                    onPressed: () async {
                                      var mensagem = await controller
                                          .removeObservation(id);
                                      Get.back();
                                      if (mensagem['code'] != null &&
                                          mensagem['code'] == 0) {
                                        Get.snackbar(
                                            'Sucesso', mensagem['objeto'],
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white);
                                        controller.getStudents();
                                      } else {
                                        Get.snackbar(
                                            'Falha', mensagem['objeto'],
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    observation.observacao?.toUpperCase() ??
                                        'OBSERVAÇÃO SEM DESCRIÇÃO',
                                    style: const TextStyle(
                                        fontSize: 14, fontFamily: 'Poppins'),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Text(
                            'Nenhuma observação disponível.',
                            style: TextStyle(fontSize: 16),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
