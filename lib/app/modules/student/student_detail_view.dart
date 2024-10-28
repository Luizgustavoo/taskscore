import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart'; // Para formatação de datas
import 'package:share_plus/share_plus.dart';
import 'package:taskscore/app/data/base_url.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';
import 'package:taskscore/app/data/models/student_model.dart';
import 'dart:io';

import 'package:taskscore/app/utils/Services.dart'; // Para salvar arquivos localmente

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
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Observações do aluno',
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
                              height: Get.width *
                                  .8, // Limite de altura para o ListView
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
                                        Services.formatDate(
                                            observation.createdAt),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    subtitle: Text(
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Chamar a função para gerar e compartilhar o PDF
          if (student.observations!.isNotEmpty) {
            await generateAndSharePdf();
          } else {
            Get.snackbar(
              'Falha',
              "Nenhuma observação cadastrada para o(a) aluno(a) selecionado(a)",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 2),
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: const Icon(
          Icons.download,
        ),
      ),
    );
  }

  Future<void> generateAndSharePdf() async {
    // Criar o documento PDF
    final pdf = pw.Document();

    // Adicionar uma página com as observações ao PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Relatório ${student.nomePessoa}",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),

            // Verificar se há observações
            student.observations != null && student.observations!.isNotEmpty
                ? pw.ListView.builder(
                    itemCount: student.observations!.length,
                    itemBuilder: (pw.Context context, int index) {
                      final observation = student.observations![index];

                      return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Data: ${Services.formatDate(observation.createdAt)}",
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Observação: ${observation.observacao?.toUpperCase() ?? 'OBSERVAÇÃO SEM DESCRIÇÃO'}",
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Divider(),
                        ],
                      );
                    },
                  )
                : pw.Text(
                    'Nenhuma observação disponível.',
                    style: const pw.TextStyle(fontSize: 16),
                  ),
          ],
        ),
      ),
    );

    // Salvar o PDF em bytes
    Uint8List pdfBytes = await pdf.save();

    // Obter o diretório temporário para salvar o arquivo
    final directory = await getTemporaryDirectory();
    final file = File("${directory.path}/student_observations.pdf");

    // Escrever os bytes do PDF no arquivo
    await file.writeAsBytes(pdfBytes);

    // Compartilhar o arquivo PDF
    await Share.shareXFiles([XFile(file.path)],
        text: "Relatório de observações do aluno.");
  }
}
