import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskscore/app/data/controllers/class_controller.dart';
import 'package:taskscore/app/data/controllers/frequency_controller.dart';
import 'package:taskscore/app/data/controllers/student_controller.dart';

class CustomClassCard extends StatelessWidget {
  const CustomClassCard({
    super.key,
    required this.dia,
    required this.aulas,
    required this.controller,
    required this.studentController,
  });

  final String dia;
  final List<Map<String, String>>? aulas;
  final ClassController controller;
  final StudentController studentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(
          dia.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Poppinss', fontSize: 20),
        ),
        Divider(
          endIndent: 70,
          indent: 70,
          height: 5,
          thickness: 2,
          color: Colors.blue.shade700,
        ),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: aulas!.map((aula) {
            Color cardColor = controller.randomColor();
            return Card(
              color: cardColor,
              child: InkWell(
                onTap: () {
                  studentController.dia = dia;
                  studentController.numeroAula = aula['numeroAula']!;
                  studentController.idHorario = aula['idHorario']!;
                  studentController.idOficina = aula['idOficina']!;
                  studentController.getStudents();
                  Get.toNamed('/student');
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            '0${aula['numeroAula']}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontFamily: 'Poppinss'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Text(
                                '${aula['alias']}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: 'Poppinss',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            studentController.viewFrequency();
                          },
                          icon: const Icon(
                            size: 30,
                            color: Colors.white,
                            Icons.person_search,
                          ))
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
